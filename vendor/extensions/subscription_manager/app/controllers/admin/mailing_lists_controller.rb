class Admin::MailingListsController < Admin::BaseController
  require_role "admin" # You might want to remove this, and add security in the /config/easy_role_permissions.yml file
  layout 'admin'
  
  resource_controller
  
  create.response do |wants|
    wants.html { redirect_to admin_mailing_lists_path }
  end
  
  update.response do |wants|
    wants.html { redirect_to admin_mailing_lists_path }
  end
  
  show.response do |wants|
    wants.html do
      subscribers = @mailing_list.users
      subscribers_emails = params[:only_plain_text] ?
        subscribers.find_all{|u| u.prefer_plain_text}.collect(&:email).join(", ") : 
        subscribers.find_all{|u| !u.prefer_plain_text}.collect(&:email).join(", ")

      render :text => subscribers_emails
    end
  end
end
