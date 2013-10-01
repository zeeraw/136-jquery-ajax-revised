require 'spec_helper'

describe ApplicationController do

  it { should respond_to :current_user }
  describe '#current_user' do

    for_session_by :user do
      it { subject.current_user.should be_kind_of User }
    end

    for_session_by :guest do
      it { subject.current_user.should be_nil }
    end

    context 'user could not be found' do

      before(:each) do
        subject.send(:cookies).signed[:auth_token] = {
          :domain =>  Figaro.env.session_key,
          :value =>   ["invalid", "token"],
          :expires => 20.years.from_now
        }
      end

      it 'repudiates the session' do
        expect(subject).to receive(:repudiate!).once
        subject.current_user.should be_nil
      end

    end

  end

  it { should respond_to :auth_token }
  describe '#auth_token' do

    for_session_by :user do
      it { subject.auth_token.should eq subject.current_user.auth_token }
    end

    for_session_by :guest do
      it { subject.auth_token.should be_nil }
    end

  end

  it { should respond_to :authenticate! }
  describe '#authenticate!' do

    let(:user) { create :user }

    before(:each) do
      subject.authenticate! user
    end

    it 'sets the auth token cookie' do
      subject.send(:cookies).signed[:auth_token].should eq user.auth_token
    end

  end

  it { should respond_to :repudiate! }
  describe '#repudiate!' do

    let(:user) { create :user }

    before(:each) do
      subject.authenticate! user
      subject.repudiate!
    end

    it 'clears the auth token cookie' do
      subject.send(:cookies).signed[:auth_token].should be_nil
    end

  end

end
