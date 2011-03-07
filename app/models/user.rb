class User < ActiveRecord::Base
  acts_as_authentic do |config|
    # make email not required (authlogic requires it by default)
    config.validate_email_field false
    config.merge_validates_length_of_email_field_options :allow_nil => true
    config.merge_validates_format_of_email_field_options :allow_nil => true
  end

  def generate_email_validation_string(length=6)  
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'  
    password = ''  
    length.times { |i| password << chars[rand(chars.length)] }  
    password  
  end
end
