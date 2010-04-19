class UserSessionsController < Spree::BaseController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar
    
  def new
    @user_session = UserSession.new
  end

  def create
    not_need_user_auto_creation = 
        user_without_openid(params[:user_session]) ||
        user_with_openid_exists?(:openid_identifier => params['openid.identity']) ||
        user_with_openid_exists?(params[:user_session]) 

    if not_need_user_auto_creation
      create_user_session(params[:user_session], params[:return_to])   
    else
      create_user(params[:user_session], params[:return_to])
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("logged_out")
    redirect_to products_path
  end
  
  def nav_bar
    render :partial => "shared/nav_bar"
  end
  
  private
  
  def user_with_openid_exists?(data)
    data && !data[:openid_identifier].blank? &&
      !!User.find(:first, :conditions => ["openid_identifier LIKE ?", "%#{data[:openid_identifier]}%"])
  end
  
  def user_without_openid(data)
    data && data[:openid_identifier].blank?
  end
  
  def create_user_session(data, return_to)
    @user_session = UserSession.new(data)
    @user_session.save do |result|
      if result
        respond_to do |format|
          format.html {
            flash[:notice] = t("logged_in_succesfully") unless session[:return_to]
            redirect_back_or_default products_path
          }
          format.js {
            user = @user_session.record
            if return_to
              redirect_to return_to
            else
              render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
            end
          }
        end
      else
        respond_to do |format|
          format.html {
            flash.now[:error] = t("login_failed")
            render :action => :new
          }
          format.js { 
            if return_to
              flash.now[:error] = t("login_failed")
              redirect_to return_to
            else
              render :json => false 
            end
          }
        end
      end
    end
    redirect_back_or_default(products_path) unless performed?
  end
  
  def create_user(data, return_to)
    @user = User.new(data)

    @user.save do |result|
      if result
        respond_to do |format|
          format.html {
            flash[:notice] = t(:user_created_successfully) unless session[:return_to]
            redirect_back_or_default products_url
          }
          format.js { redirect_to return_to }
        end
      else
        flash[:notice] = t(:missing_required_information)
        respond_to do |format|
          format.html { redirect_to :controller => :users, :action => :new, :user => {:openid_identifier => @user.openid_identifier} }
          format.js { redirect_to return_to}
        end
      end
    end
  end

  def accurate_title
    I18n.t(:log_in)
  end
  
end