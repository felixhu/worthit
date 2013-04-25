require "spec_helper"

describe RegressionsController do
  describe "routing" do

    it "routes to #index" do
      get("/regressions").should route_to("regressions#index")
    end

    it "routes to #new" do
      get("/regressions/new").should route_to("regressions#new")
    end

    it "routes to #show" do
      get("/regressions/1").should route_to("regressions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/regressions/1/edit").should route_to("regressions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/regressions").should route_to("regressions#create")
    end

    it "routes to #update" do
      put("/regressions/1").should route_to("regressions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/regressions/1").should route_to("regressions#destroy", :id => "1")
    end

  end
end
