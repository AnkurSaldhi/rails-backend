class Mydevisecontroller::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create
     #super
     #byebug
     if params[:user][:password]!= params[:user][:confirm_password]
       render :json => {response: "passwords did not match"} and return
     end

     @user = User.new(:email => params[:user][:email],:password => params[:user][:password])
     #respond_to do |format|
       if @user.save
         render :json => {response: "user successfully saved"} and return
         #format.html { redirect_to @user, notice: 'User was successfully created.' }
         #format.json { render :show, status: :created, location: @user }
       else
         render :json => {response: "user cannot be saved"} and return
         #format.html { render :new }
         #format.json { render json: @user.errors, status: :unprocessable_entity }
       #end
     end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
