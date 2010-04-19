class SubscriptionManagerHooks < Spree::ThemeSupport::HookListener

  insert_after :account_my_orders, 'users/mailing_lists'
  
  insert_after :admin_configurations_menu do
    %(<%= configurations_menu_item t('Mailing Lists'), admin_mailing_lists_path, t("Add Mailing Lists your users can opt-in to") %>)
  end

  insert_after :admin_configurations_sidebar_menu do
    %(<%= content_tag('li', link_to(t('Mailing Lists'), admin_mailing_lists_path ), :class => (controller.controller_name == 'mailing_lists' ? 'active' : nil)) %>)
  end

end
