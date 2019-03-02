require_relative "spec_helper"

def app
    SearchController
end

describe SearchController do
    it "is able to access the search page and submit the form" do
        visit '/restaurants/search'
        fill_in "city", :with => "boston"
        click_button "Next"
    end
end