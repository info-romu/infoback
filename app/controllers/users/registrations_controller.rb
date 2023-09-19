class Users::RegistrationsController < Devise::RegistrationsController
  def create # methode qui cree un stripe id a la creation de l'user 
    super 
    resource.create_on_stripe if resource.persisted?
  end

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
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end