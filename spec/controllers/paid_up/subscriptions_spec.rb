require 'rails_helper'


RSpec.describe PaidUp::SubscriptionsController do
  routes { PaidUp::Engine.routes }

  describe "GET #new" do
    context "when the user is anonymous" do
      include_context 'plans and features'
      before :each do
        access_anonymous
        get :new, plan_id: professional_plan.id
      end
      context 'redirects to the user sign up page' do
        subject { response }
        it { should redirect_to '/users/sign_in' }
        it { should have_http_status(302) }
      end
    end
    context "when the user is signed in" do
      include_context 'subscribers'
      before :each do
        sign_in free_subscriber
        get :new, plan_id: professional_plan.id
      end
      context "responds successfully with an HTTP 200 status code" do
        subject { response }
        it { should be_success }
        it { should have_http_status(200) }
      end
      context "renders the new template" do
        subject { response }
        it { should render_template("new") }
      end
      context "loads the requested plan into @plan" do
        subject { assigns(:plan) }
        it { should eq(professional_plan) }
      end
    end
  end

  describe "POST #create" do
    context "when the user is anonymous" do
      include_context 'plans and features'
      before :each do
        access_anonymous
        get :index
      end
      context 'redirects to the user sign up page' do
        subject { response }
        it { should redirect_to '/users/sign_in' }
        it { should have_http_status(302) }
      end
    end
    context "when the user is signed in" do
      context "upgrading from the default plan" do
        include_context 'subscribers'
        before :each do
          sign_in free_subscriber
          post :create, plan_id: professional_plan.id, stripeToken: working_stripe_token
        end
        context "redirects to the subscriptions index page" do
          subject { response }
          it { should redirect_to subscriptions_path }
          it { should have_http_status(302) }
        end
        context "sets a flash message" do
          subject { flash[:notice] }
          it { should match /You are now subscribed to the #{professional_plan.name} Plan/ }
        end
      end

      context "upgrading from the no ads plan" do
        include_context 'subscribers'
        before :each do
          sign_in no_ads_subscriber
          post :create, plan_id: professional_plan.id, stripeToken: working_stripe_token
        end
        context "redirects to the subscriptions index page" do
          subject { response }
          it { should redirect_to subscriptions_path }
          it { should have_http_status(302) }
        end
        context "sets a flash message" do
          subject { flash[:notice] }
          it { should match /You are now subscribed to the #{professional_plan.name} Plan/ }
        end
      end
    end
  end

  describe "GET #index" do
    context "when the user is anonymous" do
      include_context 'plans and features'
      before :each do
        access_anonymous
        get :index
      end
      context 'redirects to the user sign up page' do
        subject { response }
        it { should redirect_to '/users/sign_in' }
        it { should have_http_status(302) }
      end
    end
    context "when the user is signed in" do
      include_context 'subscribers'
      before :each do
        sign_in free_subscriber
        get :index
      end
      context "responds successfully with an HTTP 200 status code" do
        subject { response }
        it { should be_success }
        it { should have_http_status(200) }
      end
      context "renders the index template" do
        subject { response }
        it { should render_template("index") }
      end
    end
  end
end