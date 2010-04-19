# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PromotionsExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/promotions"

  # Please use promotions/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate
    base = File.dirname(__FILE__)
    Dir.glob(File.join(base, "app/**/*_decorator*.rb")){|c| load(c)}
    FileUtils.cp Dir.glob(File.join(base, "public/stylesheets/*.css")), File.join(RAILS_ROOT, "public/stylesheets/")
    FileUtils.cp Dir.glob(File.join(base, "public/javascripts/*.js")), File.join(RAILS_ROOT, "public/javascripts")

    if ProductPromotion.table_exists?
      [Calculator::CheapestFree, Calculator::FreeShipping, Calculator::NAndMoreProducts, Calculator::NoCharge, Calculator::NthFree].each do |calculator|
        calculator.register(ProductPromotion)
      end
      UserPromotion.register_calculator(Calculator::FlatPercentItemTotal)
      PromotionOrderObserver.instance
    end

    ::Adjustment
    ::Credit
    ::PromotionCredit
    ::ProductPromotion

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    Admin::BaseController.class_eval do
      before_filter :add_promotions_tab

      def add_promotions_tab
        # add_extension_admin_tab takes an array containing the same arguments expected
        # by the tab helper method:
        #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
        if respond_to?(:add_extension_admin_tab)
          add_extension_admin_tab [:promotions, :product_promotions, :user_promotions, :coupons]
        end
      end
    end

    ## Commented out by calas 'cause the submenu was rendered twice.
    # Admin::CouponsController.class_eval do
    #   before_filter :promotions_submenu
    #   def promotions_submenu
    #     render_to_string :partial => 'admin/shared/promotions_sub_menu'
    #   end
    # end

    [ProductsController, Spree::BaseController].each{|c| c.helper 'promotions'}

    Rails.cache.silence!

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
