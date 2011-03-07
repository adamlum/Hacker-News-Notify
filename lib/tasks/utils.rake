namespace :utils do
  desc "This will scan the new posts to Hacker News"
  task(:scan_hacker_news_new => :environment) do
    require 'rubygems'
    require 'hpricot'
    require 'open-uri'

    links = []
    link_titles = []
    discuss_link = []
    usernames = []
    domains = []

    done = false
    hn_url = "http://news.ycombinator.com/newest"

    until done
      done = true
      doc = Hpricot(open(hn_url).read)
      (doc/"td.title/a").each do |link|
        if link.inner_html.strip != "scribd" && link.inner_html.strip != "More"
          link_titles << link.inner_html
          links << link.attributes["href"]
          if link.attributes["href"].match("http://")
            domains << link.attributes["href"].split("/")[2]
          else
            domains << "ycombinator.com"
          end
        end
        if link.inner_html.strip == "More"
          done = false
          hn_url = "http://news.ycombinator.com" + link.attributes["href"]
        end
      end

      counter = 0
      (doc/"td.subtext/a").each do |sublink|
        if counter % 2 == 0
          usernames << sublink.inner_html
        else
          discuss_link << sublink.attributes["href"].gsub("item?id=", "")
        end
        counter += 1
      end
    end

    # Keyword
    Watchlist.find(:all, :conditions => {:watchlist_type_id => 1}).each do |w|
      for i in 0..link_titles.length - 1 do
        if link_titles[i].strip.downcase.include?(w.term.strip.downcase) && !Match.find(:first, :conditions => {:watchlist_id => w.id, :post_number => discuss_link[i]})
          m = Match.new(:post_title => link_titles[i], :post_by => usernames[i], :post_url => links[i], :post_number => discuss_link[i], :watchlist_id => w.id)
          m.save
          if w.email_notify
            Emailer.deliver_notification_email(w.user.email, w.user.username, w.watchlist_type.name, w.term, links[i], "http://news.ycombinator.com/item?id=" + discuss_link[i])
          end
        end
      end
    end
    
    # User
    Watchlist.find(:all, :conditions => {:watchlist_type_id => 2}).each do |w|
      for i in 0..usernames.length - 1 do
        if usernames[i].strip.downcase == w.term.strip.downcase && !Match.find(:first, :conditions => {:watchlist_id => w.id, :post_number => discuss_link[i]})
          m = Match.new(:post_title => link_titles[i], :post_by => usernames[i], :post_url => links[i], :post_number => discuss_link[i], :watchlist_id => w.id)
          m.save
          if w.email_notify
            Emailer.deliver_notification_email(w.user.email, w.user.username, w.watchlist_type.name, w.term, links[i], "http://news.ycombinator.com/item?id=" + discuss_link[i])
          end
        end
      end
    end
    
    # Domain
    Watchlist.find(:all, :conditions => {:watchlist_type_id => 3}).each do |w|
      for i in 0..link_titles.length - 1 do
        if domains[i].strip.downcase.include?(w.term.strip.downcase) && !Match.find(:first, :conditions => {:watchlist_id => w.id, :post_number => discuss_link[i]})
          m = Match.new(:post_title => link_titles[i], :post_by => usernames[i], :post_url => links[i], :post_number => discuss_link[i], :watchlist_id => w.id)
          m.save
          if w.email_notify
            Emailer.deliver_notification_email(w.user.email, w.user.username, w.watchlist_type.name, w.term, links[i], "http://news.ycombinator.com/item?id=" + discuss_link[i])
          end
        end
      end
    end
  end
end
