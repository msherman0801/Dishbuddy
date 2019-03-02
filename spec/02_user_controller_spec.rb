require_relative "spec_helper"

def app
    UserController
end

describe UserController do
    it "responds with the user profile and a 200 status code" do
        get '/user'
        session[:user_id] = 1
        # expect(last_response.body).to include('Home')
        # @user = User.create(username: "Matt", email: "Matt@gmail.com", password: "123")
       # expect(page.current_path).to eq('/user/profile')
    end

    # describe 'GET "/user"' do
    #     it "passes along the prior session with :user_id" do
    #         visit '/home'
    #         click_button "My Profile"
    #     end
    # end


end

