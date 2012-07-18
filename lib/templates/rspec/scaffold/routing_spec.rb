<%-
  root = controller_class_name.split("::").map{|p| p.underscore}.join("/")
-%>
require "spec_helper"

describe <%= controller_class_name %>Controller do
  describe "routing" do

<% unless options[:singleton] -%>
    it "routes to #index" do
      get("/<%= root %>").should route_to("<%= root %>#index")
    end

<% end -%>
    it "routes to #new" do
      get("/<%= root %>/new").should route_to("<%= root %>#new")
    end

    it "routes to #show" do
      get("/<%= root %>/1").should route_to("<%= root %>#show", :id => "1")
    end

    it "routes to #edit" do
      get("/<%= root %>/1/edit").should route_to("<%= root %>#edit", :id => "1")
    end

    it "routes to #create" do
      post("/<%= root %>").should route_to("<%= root %>#create")
    end

    it "routes to #update" do
      put("/<%= root %>/1").should route_to("<%= root %>#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/<%= root %>/1").should route_to("<%= root %>#destroy", :id => "1")
    end

  end
end
