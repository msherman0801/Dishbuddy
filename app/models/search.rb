class Search < ActiveRecord::Base

    #Api.fetch(Search.linkify({"entity_id" => "289", "establishment_type" => "8"}))
    def self.linkify(params)
        search_string = ["https://developers.zomato.com/api/v2.1/"]
        search_string << "cities?q=#{params["cities"]}" if !params["cities"].nil?
        search_string << "establishments?city_id=#{params["city"]}" if !params["city"].nil?
        search_string << "restaurant?res_id=#{params["res_id"]}" if !params["res_id"].nil?
        search_string << "search?entity_id=#{params["entity_id"]}" if !params["entity_id"].nil?
        search_string << "&entity_type=city" if !params["entity_id"].nil?
        search_string << "&establishment_type=#{params["establishment_id"]}" if !params["establishment_id"].nil?
        search_string.join('')
    end

end