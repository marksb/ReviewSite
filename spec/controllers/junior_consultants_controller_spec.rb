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

describe JuniorConsultantsController do

  # This should return the minimal set of attributes required to create a valid
  # JuniorConsultant. As you add validations to JuniorConsultant, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { name: "John Smith",
      email: "john@tw.com",
      notes: "This is a dev"}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JuniorConsultantsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "as a normal user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "cannot list all JCs" do
      get :index, {}, valid_session
      response.should redirect_to(root_path)
    end
    it "cannot GET new" do
      get :new, {}, valid_session
      assigns(:junior_consultant).should be_a_new(JuniorConsultant)
      response.should redirect_to(root_path)
    end
    it "cannot GET edit" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      get :edit, {:id => junior_consultant.to_param}, valid_session
      response.should redirect_to(root_path)
    end
    it "cannot POST create" do
      post :create, {:junior_consultant => valid_attributes}, valid_session
      response.should redirect_to(root_path)
    end
    it "cannot PUT update" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      put :update, {:id => junior_consultant.to_param, :junior_consultant => valid_attributes}, valid_session
      response.should redirect_to(root_path)
    end
    it "cannot DELETE destroy" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      delete :destroy, {:id => junior_consultant.to_param}, valid_session
      response.should redirect_to(root_path)
    end
  end

  describe "when not signed in" do
    it "cannot list all JCs" do
      get :index, {}, valid_session
      response.should redirect_to(signin_path)
    end
  end

  describe "GET index" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    it "assigns all junior_consultants as @junior_consultants" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      get :index, {}, valid_session
      assigns(:junior_consultants).should eq([junior_consultant])
    end
  end

  describe "GET new" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    it "assigns a new junior_consultant as @junior_consultant" do
      get :new, {}, valid_session
      assigns(:junior_consultant).should be_a_new(JuniorConsultant)
    end
  end

  describe "GET edit" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    it "assigns the requested junior_consultant as @junior_consultant" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      get :edit, {:id => junior_consultant.to_param}, valid_session
      assigns(:junior_consultant).should eq(junior_consultant)
    end
  end

  describe "POST create" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    describe "with valid params" do
      it "creates a new JuniorConsultant" do
        expect {
          post :create, {:junior_consultant => valid_attributes}, valid_session
        }.to change(JuniorConsultant, :count).by(1)
      end

      it "assigns a newly created junior_consultant as @junior_consultant" do
        post :create, {:junior_consultant => valid_attributes}, valid_session
        assigns(:junior_consultant).should be_a(JuniorConsultant)
        assigns(:junior_consultant).should be_persisted
      end

      it "redirects to the junior_consultants index" do
        post :create, {:junior_consultant => valid_attributes}, valid_session
        response.should redirect_to(junior_consultants_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved junior_consultant as @junior_consultant" do
        # Trigger the behavior that occurs when invalid params are submitted
        JuniorConsultant.any_instance.stub(:save).and_return(false)
        post :create, {:junior_consultant => {}}, valid_session
        assigns(:junior_consultant).should be_a_new(JuniorConsultant)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        JuniorConsultant.any_instance.stub(:save).and_return(false)
        post :create, {:junior_consultant => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    describe "with valid params" do
      it "updates the requested junior_consultant" do
        junior_consultant = JuniorConsultant.create! valid_attributes
        # Assuming there are no other junior_consultants in the database, this
        # specifies that the JuniorConsultant created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        JuniorConsultant.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => junior_consultant.to_param, :junior_consultant => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested junior_consultant as @junior_consultant" do
        junior_consultant = JuniorConsultant.create! valid_attributes
        put :update, {:id => junior_consultant.to_param, :junior_consultant => valid_attributes}, valid_session
        assigns(:junior_consultant).should eq(junior_consultant)
      end

      it "redirects to the junior_consultant" do
        junior_consultant = JuniorConsultant.create! valid_attributes
        put :update, {:id => junior_consultant.to_param, :junior_consultant => valid_attributes}, valid_session
        response.should redirect_to(junior_consultants_path)
      end
    end

    describe "with invalid params" do
      it "assigns the junior_consultant as @junior_consultant" do
        junior_consultant = JuniorConsultant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JuniorConsultant.any_instance.stub(:save).and_return(false)
        put :update, {:id => junior_consultant.to_param, :junior_consultant => {}}, valid_session
        assigns(:junior_consultant).should eq(junior_consultant)
      end

      it "re-renders the 'edit' template" do
        junior_consultant = JuniorConsultant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JuniorConsultant.any_instance.stub(:save).and_return(false)
        put :update, {:id => junior_consultant.to_param, :junior_consultant => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in @admin_user
    end
    it "destroys the requested junior_consultant" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      expect {
        delete :destroy, {:id => junior_consultant.to_param}, valid_session
      }.to change(JuniorConsultant, :count).by(-1)
    end

    it "redirects to the junior_consultants list" do
      junior_consultant = JuniorConsultant.create! valid_attributes
      delete :destroy, {:id => junior_consultant.to_param}, valid_session
      response.should redirect_to(junior_consultants_url)
    end
  end

end