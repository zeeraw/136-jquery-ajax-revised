require 'spec_helper'

describe SessionsController do

  it { should respond_to :create }
  describe '#create' do

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it 'assigns @current_user' do
      get :create
      expect(assigns(:current_user)).to be_a User
    end

  end

  it { should respond_to :destroy }
  describe '#destroy' do

    for_session_by :user do
      it 'assigns @current_user to nil' do
        get :destroy
        expect(assigns(:current_user)).to be_nil
      end
    end

  end

  describe 'Routing' do

    it "GET '/auth/twitter/callback' to #create" do
      expect( get: "/auth/twitter/callback" ).to route_to(
        controller: "sessions",
        action:     "create"
      )
    end

    it "GET '/logout' to #destroy" do
      expect( get: "/logout" ).to route_to(
        controller: "sessions",
        action:     "destroy"
      )
    end
  end

end
