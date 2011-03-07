class Emailer < ActionMailer::Base
 def validation_email(recipient, username, validation_code)
    @from = "no-reply@hnnotify.com"
    @recipients = recipient
    @subject = "Validate Your Email Address for hnnotify.com"
    @body["recipient"] = recipient
    @body["validation_code"] = validation_code
    @body["username"] = username
  end

  def notification_email(recipient, username, watchlist_type, watchlist_term, post_url, comments_url)
    @from = "no-reply@hnnotify.com"
    @recipients = recipient
    @subject = "Notification for " + watchlist_term + " on Hacker News"
    @body["username"] = username
    @body["watchlist_type"] = watchlist_type
    @body["watchlist_term"] = watchlist_term
    @body["post_url"] = post_url
    @body["comments_url"] = comments_url
  end
end
