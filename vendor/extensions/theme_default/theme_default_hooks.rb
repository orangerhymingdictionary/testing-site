class ThemeDefaultHooks < Spree::ThemeSupport::HookListener
insert_after :inside_head, 'shared/styles'
insert_before :homepage_products, 'shared/homepage_banner'
insert_before :homepage_products, :text => "<h1>Welcome!</h1>"


end
