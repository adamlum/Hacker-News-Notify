class StaticController < ApplicationController
  def index
  end

  def test_email
    Emailer::deliver_validation_email("adam.lum@gmail.com", "aabbccd")
  end
end
