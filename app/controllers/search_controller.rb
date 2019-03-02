class SearchController < ApplicationController

    @@item = nil

    get '/search' do
        redirect '/restaurants/search'
    end

    get '/restaurants/search' do
        erb :'/restaurants/search/step-1'   
    end

    post '/restaurants/search/step-1' do
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
        @progress = "40"
        @establishments = Api.fetch(Search.linkify({"city"=>session["city"]}))["establishments"]
        erb :'/restaurants/search/step-2'
    end

    post '/restaurants/search/step-2' do
        @progress = "80"
        params["entity_id"] = session["city"]
        @restaurants = Api.fetch(Search.linkify(params))
        erb :'/restaurants/search/results'
    end

    get '/restaurants/search/show' do
        res = Restaurant.all.find{|i| i.res_id == params["res"]["res_id"]}
        user = Helpers.user(session)
        @reviews = []
        @progress = "100"
        @restaurant = Api.fetch(Search.linkify(params["res"]))
        if !user.restaurants.include?(res)
            @button = ["btn-success","Add to my DishList"]
        else
            @button = ["btn-danger","Remove from my DishList"]
        end
        erb :'/restaurants/search/show'
    end

    post '/restaurants/search/show' do
        user = Helpers.user(session)
        res = Restaurant.all.find{|i| i.res_id == params["res"]["res_id"]}
        if res && !user.restaurants.include?(res)
            user.restaurants << res
        elsif !res && !user.restaurants.include?(res)
            user.restaurants << Restaurant.create(params[:res])
        elsif res && user.restaurants.include?(res)
            user.restaurants.delete(res)
        end
        redirect '/users/profile'
    end
    # get '/restaurants/search/results' do
    #     binding.pry
    #     @restaurants = @@item
    #     erb :'/restaurants/search/results'
    # end

end