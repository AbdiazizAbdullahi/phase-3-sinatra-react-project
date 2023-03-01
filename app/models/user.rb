class User < ActiveRecord::Base
    has_many :pets

    # def self.authenticate(phone, password)
    #     user = find_by(phone: phone)
    #     return user if user&.authenticate(password)
      
    #     nil
    # end
       
end 