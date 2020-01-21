
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { "password"} 
      password_confirmation { "password" }
      
    end
    factory :todo do |f|
      f.content { "aker::Name.first_name" }
    end
    factory :invalid_todo, parent: :todo do |f|
      f.content {nil}
    end
  end
  
module ControllerMacros
  def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
 # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in user
      end
    end
  end