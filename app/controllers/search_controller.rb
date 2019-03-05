class SearchController < ApplicationController
    @@item = nil

    get '/search' do
        protected!
 
        redirect '/restaurants/search'
    end

    get '/restaurants/search' do
        protected!
 
        erb :'/restaurants/search/step-1'   
    end

    post '/restaurants/search/step-1' do
        protected!
 
        @progress = "0"
        if params["cities"] 
            @progress = "20"
            @cities = Api.fetch(Search.linkify(params))["location_suggestions"]
            erb :'/restaurants/search/step-1'
        else
            session["city"] = params[:city]
            redirect '/restaurants/search/step-2'
        end
    end

    get '/restaurants/search/step-2' do
        protected!
 
        @progress = "40"
        @establishments = Api.fetch(Search.linkify({"city"=>session["city"]}))["establishments"]
        erb :'/restaurants/search/step-2'
    end

    post '/restaurants/search/step-2' do
        protected!
 
        @progress = "80"
        params["entity_id"] = session["city"]
        @restaurants = Api.fetch(Search.linkify(params))
        erb :'/restaurants/search/results'
    end

    get '/restaurants/search/show' do
        protected!

        @error = true if params[:failure] == true
        @res = Restaurant.all.find{|i| i.res_id == params["res"]["res_id"]}
        user = Helpers.user(session)
        @reviews = UserRestaurant.all.map{|i| i if i.restaurant_id == @res.id && !i.review.nil?}.compact
        @progress = "100"
        @restaurant = Api.fetch(Search.linkify(params["res"]))
        if !user.restaurants.include?(@res)
            @button = ["btn-success","Add to my DishList"]
        else
            @button = ["btn-danger","Remove from my DishList"]
        end
        erb :'/restaurants/search/show'
    end

    post '/restaurants/search/review' do 
        res = Restaurant.find(params[:res_id])
        user_restaurant = UserRestaurant.find_by("user_id" => session[:user_id], "restaurant_id" => (res.id if !res.id.nil?))
        if !user_restaurant.nil?
            user_restaurant.review = params[:review]
            user_restaurant.save
        else
            redirect "/restaurants/search/show?res[res_id]=#{res.res_id}&failure=true"
        end
        redirect "/restaurants/search/show?res[res_id]=#{res.res_id}"
    end

    post '/restaurants/search/show' do
        protected!
 
        user = Helpers.user(session)
        res = Restaurant.all.find{|i| i.res_id == params["res"]["res_id"]}
        if res && !user.restaurants.include?(res)
            user.restaurants << res
        elsif !res && !user.restaurants.include?(res)
            res = Restaurant.create(params[:res])
            user.restaurants << res
        elsif res && user.restaurants.include?(res)
            user.restaurants.delete(res)
        end
        redirect "/restaurants/search/show?res[res_id]=#{res.res_id}"
    end
    # get '/restaurants/search/results' do
    #     binding.pry
    #     @restaurants = @@item
    #     erb :'/restaurants/search/results'
    # end

end