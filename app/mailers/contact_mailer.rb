class ContactMailer < ApplicationMailer

    def contact_email(name, company_name, from_email, phone_number, counter_type, message)
        @name = name
        @mail = mail
        @company_name = company_name
        @phone_number = phone_number
        @counter_type = counter_type
        @message = message
        @from_email = from_email

        mail(from: from_email, to: 'infotest@gmail.com', subject: 'Demande d\'un devis')
    end
end
