require "rails_helper"

RSpec.describe UserProdutosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_produtos").to route_to("user_produtos#index")
    end

    it "routes to #show" do
      expect(get: "/user_produtos/1").to route_to("user_produtos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_produtos").to route_to("user_produtos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_produtos/1").to route_to("user_produtos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_produtos/1").to route_to("user_produtos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_produtos/1").to route_to("user_produtos#destroy", id: "1")
    end
  end
end
