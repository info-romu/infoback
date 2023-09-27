class ContactController < ApplicationController

    def send_email
        name = params[:name]
        company_name = params[:company_name]
        mail = params[:mail]
        phone_number = params[:phone_number]
        counter_type = params[:counter_type]
        message = params[:message]

        ContactMailer.contact_email(name, company_name, mail, phone_number, counter_type, message).deliver_now
        render json: { message: 'E-mail envoyé avec succès' }, status: :ok
    end
end
