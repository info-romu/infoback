class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
   def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
   end
   
  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: {
      message: 'Signed up sucessfully.',
      user: current_user
    }, status: :ok
    UserMailer.registration_confirmation(current_user).deliver_now
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end