require "rails_helper"

RSpec.describe StoresController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should list stores" do
      stores = create_list(:store, 10)
      visit root_path
    end
  end
end
