class SubscriptionsController < Spree::BaseController
  before_filter :require_user
  
  def email_preferences
    @mailing_lists = MailingList.all
    @user = current_user
  end
end
