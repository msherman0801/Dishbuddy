require_relative "spec_helper"

def app
  ApplicationController
end

describe ApplicationController do
  it "responds with a welcome message" do
    get '/'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Welcome to the Sinatra Template!")
  end

    it "has a form to register a user" do
      get '/register'
      expect(last_response.body).to include('<button type="submit">')
    end

    describe "GET '/register'" do 
      it 'returns a 200 status code' do 
        get '/register'
        expect(last_response.status).to eq(200)
      end
  
      it 'returns contains a form to register' do 
        visit '/register'
        expect(page).to have_selector("form")
        expect(page).to have_field(:username)
        expect(page).to have_field(:password)
        expect(page).to have_field(:email)
      end
    end
  
    describe "POST '/register'" do 
      it 'returns a 200 status code' do 
        visit '/register'
        fill_in "username", :with => "testaccount1"
        fill_in "password", :with => "testpassword1"
        fill_in "email", :with => "test@test.com"
        
        click_button "Submit"
        expect(page.current_path).to eq('/home')
        expect(page.status_code).to eq(200)
      end
    end

    describe "GET '/login'" do
      it 'returns a 200 status code' do
        get '/login'
        expect(last_response.status).to eq(200)
      end

      it 'returns a form to login' do
        visit '/login'
          expect(page).to have_field(:username)
          expect(page).to have_field(:password)
      end
    end

    describe "POST '/login'" do
      it 'returns a 200 status code' do
        visit '/login'
        fill_in "username", :with => "testaccount1"
        fill_in "password", :with => "testpassword1"
        click_button "Login"
        expect(page.current_path).to eq('/home')
        expect(page.status_code).to eq(200)
      end

      it 'gets to post' do
        params = {
        "username"=> "testaccount1", "password" => "testpassword1"
        } 
        post '/login', params
          expect(last_response.status).to eq(302)
      end
      ##deletes database entries AFTER all rspec is run.
        # RSpec.configure do |config|
        #   config.after do
        #     DatabaseCleaner.clean 
        #   end
        # end
    end
end


