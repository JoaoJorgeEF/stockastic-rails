require "rails_helper"

RSpec.describe ProdutosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/produtos").to route_to("produtos#index")
    end

    it "routes to #show" do
      expect(get: "/produtos/1").to route_to("produtos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/produtos").to route_to("produtos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/produtos/1").to route_to("produtos#update", id: "1")
    end

    it "routes to #incrementar_quantidade via PUT" do
      expect(put: "/produtos/1/incrementar_quantidade").to route_to("produtos#incrementar_quantidade", id: "1")
    end

    it "routes to #decrementar_quantidade via PUT" do
      expect(put: "/produtos/1/decrementar_quantidade").to route_to("produtos#decrementar_quantidade", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/produtos/1").to route_to("produtos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/produtos/1").to route_to("produtos#destroy", id: "1")
    end
  end
end
