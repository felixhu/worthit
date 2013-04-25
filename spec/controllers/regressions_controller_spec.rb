require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe RegressionsController do

  # This should return the minimal set of attributes required to create a valid
  # Regression. As you add validations to Regression, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "constant" => "1.5" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RegressionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all regressions as @regressions" do
      regression = Regression.create! valid_attributes
      get :index, {}, valid_session
      assigns(:regressions).should eq([regression])
    end
  end

  describe "GET show" do
    it "assigns the requested regression as @regression" do
      regression = Regression.create! valid_attributes
      get :show, {:id => regression.to_param}, valid_session
      assigns(:regression).should eq(regression)
    end
  end

  describe "GET new" do
    it "assigns a new regression as @regression" do
      get :new, {}, valid_session
      assigns(:regression).should be_a_new(Regression)
    end
  end

  describe "GET edit" do
    it "assigns the requested regression as @regression" do
      regression = Regression.create! valid_attributes
      get :edit, {:id => regression.to_param}, valid_session
      assigns(:regression).should eq(regression)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Regression" do
        expect {
          post :create, {:regression => valid_attributes}, valid_session
        }.to change(Regression, :count).by(1)
      end

      it "assigns a newly created regression as @regression" do
        post :create, {:regression => valid_attributes}, valid_session
        assigns(:regression).should be_a(Regression)
        assigns(:regression).should be_persisted
      end

      it "redirects to the created regression" do
        post :create, {:regression => valid_attributes}, valid_session
        response.should redirect_to(Regression.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved regression as @regression" do
        # Trigger the behavior that occurs when invalid params are submitted
        Regression.any_instance.stub(:save).and_return(false)
        post :create, {:regression => { "constant" => "invalid value" }}, valid_session
        assigns(:regression).should be_a_new(Regression)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Regression.any_instance.stub(:save).and_return(false)
        post :create, {:regression => { "constant" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested regression" do
        regression = Regression.create! valid_attributes
        # Assuming there are no other regressions in the database, this
        # specifies that the Regression created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Regression.any_instance.should_receive(:update).with({ "constant" => "1.5" })
        put :update, {:id => regression.to_param, :regression => { "constant" => "1.5" }}, valid_session
      end

      it "assigns the requested regression as @regression" do
        regression = Regression.create! valid_attributes
        put :update, {:id => regression.to_param, :regression => valid_attributes}, valid_session
        assigns(:regression).should eq(regression)
      end

      it "redirects to the regression" do
        regression = Regression.create! valid_attributes
        put :update, {:id => regression.to_param, :regression => valid_attributes}, valid_session
        response.should redirect_to(regression)
      end
    end

    describe "with invalid params" do
      it "assigns the regression as @regression" do
        regression = Regression.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Regression.any_instance.stub(:save).and_return(false)
        put :update, {:id => regression.to_param, :regression => { "constant" => "invalid value" }}, valid_session
        assigns(:regression).should eq(regression)
      end

      it "re-renders the 'edit' template" do
        regression = Regression.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Regression.any_instance.stub(:save).and_return(false)
        put :update, {:id => regression.to_param, :regression => { "constant" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested regression" do
      regression = Regression.create! valid_attributes
      expect {
        delete :destroy, {:id => regression.to_param}, valid_session
      }.to change(Regression, :count).by(-1)
    end

    it "redirects to the regressions list" do
      regression = Regression.create! valid_attributes
      delete :destroy, {:id => regression.to_param}, valid_session
      response.should redirect_to(regressions_url)
    end
  end

end
