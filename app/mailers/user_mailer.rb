class UserMailer < ApplicationMailer

    def registration_confirmation(user)
        @user = user
        mail(to: @user.email, subject: "Bienvenue chez Inforomu !")
    end


    def purchase_confirmation(user, item, total_price)
        @user = user
        @items = item
        @total_price = total_price
        mail(to: @user.email, subject: 'Confirmation d\'achat ')
        puts "mail okokokokok"
    end
end
