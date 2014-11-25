class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  
  
  def upload
    uploaded_io = params[:user][:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

    protected

    # my custom fields are :name, :heard_how
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:username, :email, :picture, :password, :password_confirmation)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:username, :picture, :email, :password, :password_confirmation, :current_password)
      end
    end

end