class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  validates_format_of :email, :with => Format::EMAIL_REGEX, :allow_nil => true
end
