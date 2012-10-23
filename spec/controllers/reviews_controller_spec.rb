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

describe ReviewsController do

  # This should return the minimal set of attributes required to create a valid
  # Review. As you add validations to Review, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { 
        review_type: '6-Month',
        junior_consultant_id: 1,
        review_date: Date.today,
        feedback_deadline: Date.today,
        send_link_date: Date.today
    }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReviewsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET show" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    it "assigns the requested review as @review" do
      review = Review.create! valid_attributes
      get :show, {:id => review.to_param}, valid_session
      assigns(:review).should eq(review)
    end
  end

  describe "GET summary" do
    before(:each) do
      @review = FactoryGirl.create(:review)
      @feedback_sub = FactoryGirl.create(:submitted_feedback, :review => @review)
      @feedback_unsub = FactoryGirl.create(:feedback, :review => @review)
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    it "assigns ONLY submitted feedback as @feedbacks" do
      get :summary, {:id => @review.to_param}, valid_session
      response.should be_success
      assigns(:feedbacks).should eq([@feedback_sub])
    end
    it "can be seen by the feedback target" do
      jc_user = FactoryGirl.create(:user, :email => @review.junior_consultant.email)
      sign_in jc_user
      get :summary, {:id => @review.to_param}, valid_session
      response.should be_success
      assigns(:feedbacks).should eq([@feedback_sub])
    end
  end

  describe "GET new" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    it "assigns a new review as @review" do
      get :new, {}, valid_session
      assigns(:review).should be_a_new(Review)
    end
  end
  describe "when signed out" do
    it "cannot GET new" do
      get :new, {}, valid_session
      response.should redirect_to(signin_path)
    end
    it "cannot GET edit" do
      review = Review.create! valid_attributes
      get :edit, {:id => review.to_param}, valid_session
      response.should redirect_to(signin_path)
    end
    it "cannot POST create" do
      review = Review.create! valid_attributes
      post :create, {:review => valid_attributes}, valid_session
      response.should redirect_to(signin_path)
    end
    it "cannot PUT update" do
      review = Review.create! valid_attributes
      put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
      response.should redirect_to(signin_path)
    end
    it "cannot DELETE destroy" do
      review = Review.create! valid_attributes
      delete :destroy, {:id => review.to_param}, valid_session
      response.should redirect_to(signin_path)
    end
  end

  describe "GET edit" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    it "assigns the requested review as @review" do
      review = Review.create! valid_attributes
      get :edit, {:id => review.to_param}, valid_session
      assigns(:review).should eq(review)
    end
  end

  describe "POST create" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    describe "with valid params" do
      it "creates a new Review" do
        expect {
          post :create, {:review => valid_attributes}, valid_session
        }.to change(Review, :count).by(1)
      end

      it "assigns a newly created review as @review" do
        post :create, {:review => valid_attributes}, valid_session
        assigns(:review).should be_a(Review)
        assigns(:review).should be_persisted
      end

      it "redirects to the created review" do
        post :create, {:review => valid_attributes}, valid_session
        response.should redirect_to(Review.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved review as @review" do
        # Trigger the behavior that occurs when invalid params are submitted
        Review.any_instance.stub(:save).and_return(false)
        post :create, {:review => {}}, valid_session
        assigns(:review).should be_a_new(Review)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Review.any_instance.stub(:save).and_return(false)
        post :create, {:review => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    describe "with valid params" do
      it "updates the requested review" do
        review = Review.create! valid_attributes
        # Assuming there are no other reviews in the database, this
        # specifies that the Review created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Review.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => review.to_param, :review => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested review as @review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
        assigns(:review).should eq(review)
      end

      it "redirects to the review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
        response.should redirect_to(review)
      end
    end

    describe "with invalid params" do
      it "assigns the review as @review" do
        review = Review.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Review.any_instance.stub(:save).and_return(false)
        put :update, {:id => review.to_param, :review => {}}, valid_session
        assigns(:review).should eq(review)
      end

      it "re-renders the 'edit' template" do
        review = Review.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Review.any_instance.stub(:save).and_return(false)
        put :update, {:id => review.to_param, :review => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @admin_user = FactoryGirl.create(:admin_user)
      sign_in(@admin_user)
    end
    it "destroys the requested review" do
      review = Review.create! valid_attributes
      expect {
        delete :destroy, {:id => review.to_param}, valid_session
      }.to change(Review, :count).by(-1)
    end

    it "redirects to the reviews list" do
      review = Review.create! valid_attributes
      delete :destroy, {:id => review.to_param}, valid_session
      response.should redirect_to(welcome_index_url)
    end
  end

end
