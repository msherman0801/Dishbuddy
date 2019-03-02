class UserController < ApplicationController

    get '/users' do
        redirect '/users/profile'
    end

    get '/users/profile' do
        if Helpers.is_logged_in?(session)
            @self = Helpers.user(session)
            @friends = @self.friends
            erb :"/users/profile"
        else
            redirect '/login'
        end
    end

    get '/users/friends' do
        @self = Helpers.user(session)
        erb :"/users/friends"
    end

    post '/users/profile' do
        user = Helpers.user(session)
        if !params.include?("delete")
            user.update(params.each {|k,v| params.delete(k) if v.empty?})
            user.save
            redirect '/users/profile'
        else
            user.destroy
            redirect '/login'
        end
    end

    get '/users/:id' do
        @friend = User.all.find{|i| i.id == params[:id].to_i}
        @self = Helpers.user(session)
        if @self.friends.include?(@friend)
            @button = "Unfollow"
        else 
            @button = "Follow"
        end
        if  @friend != nil
            erb :"/users/account"
        else
            erb :failure
        end
    end

    post '/users/follow' do
        @self = Helpers.user(session)
        @friend = User.find(params[:id])
        has_friend = @self.friends.include?(@friend)
        if has_friend
            @self.friends.delete(@friend)
            @self.save
        elsif !has_friend
            @self.friends << @friend
            @self.save
        end
        redirect "/users/#{@friend.id}"
    end
end