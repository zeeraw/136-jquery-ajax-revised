require 'spec_helper'

describe User do

  let(:subject) { create(:user) }

  it { subject.should respond_to :name }
  it { subject.should respond_to :avatar }
  it { subject.should respond_to :handle }
  it { subject.should respond_to :twitter_token }
  it { subject.should respond_to :twitter_secret }
  it { subject.should respond_to :twitter_uid }

  it { subject.class.should respond_to :find_by_auth_token }
  describe '.find_by_auth_token' do

    subject { create :user }

    let(:auth_token) { subject.auth_token }

    it 'finds user' do
      User.find_by_auth_token(auth_token).should eq subject
    end

    context 'no user exists' do
      let(:auth_token) { ["invalid", "token"] }
      it 'expects RecordNotFound error'do
        expect do
          User.find_by_auth_token(auth_token)
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

  end

  it { subject.class.should respond_to :derive_from_twitter }
  describe '.derive_from_twitter' do

    let(:subject) { User }

    let(:omniauth_hash) { OmniAuth.config.mock_auth[:twitter] }

    it { subject.derive_from_twitter(omniauth_hash).should be_new_record }

    it { subject.derive_from_twitter(omniauth_hash).twitter_uid.should eq    '123545' }
    it { subject.derive_from_twitter(omniauth_hash).twitter_secret.should eq '29293db8cf6bca8eeb16bccba7df7179' }
    it { subject.derive_from_twitter(omniauth_hash).twitter_token.should eq  '80e3aad93519dcd3' }

    it { subject.derive_from_twitter(omniauth_hash).name.should eq   'omniauth' }
    it { subject.derive_from_twitter(omniauth_hash).handle.should eq 'omniauth' }
    it { subject.derive_from_twitter(omniauth_hash).avatar.should eq 'http://omniauth.com/image.png' }

    context 'user already exists' do

      before(:each) { user }
      let(:user) { create(:omniauth_user) }

      it 'finds matching record' do
        subject.derive_from_twitter(omniauth_hash).should eq user.reload
      end

      it { subject.derive_from_twitter(omniauth_hash).should_not be_new_record }

      context 'some attributes are updated' do

        let(:user) { create(:omniauth_user, avatar: 'old', name: 'old', handle: 'old') }

        it { subject.derive_from_twitter(omniauth_hash).name.should eq   'omniauth' }
        it { subject.derive_from_twitter(omniauth_hash).handle.should eq 'omniauth' }
        it { subject.derive_from_twitter(omniauth_hash).avatar.should eq 'http://omniauth.com/image.png' }

      end

    end

  end

  describe '#save' do

    context 'name is invalid' do
      it { build(:user, name: nil).save.should be_false }
    end

    context 'avatar is invalid' do
      it { build(:user, avatar: nil).save.should be_false }
    end

    context 'handle is invalid' do
      it { build(:user, handle: nil).save.should be_false }
    end

  end

  describe '#auth_token' do
    it { subject.auth_token.should eq [subject.twitter_token, subject.twitter_secret] }
    it { subject.auth_token.should be_kind_of Array }
  end

end
