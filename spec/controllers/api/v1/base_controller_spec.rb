require 'rails_helper'

describe API::V1::BaseController do

  let!(:user) { create(:user, email:'test@test.com') }
  let!(:session) { create(:session, user: user)}

  describe 'Filter methods' do

    describe '#authenticate_user_from_token!' do

      context 'when `authorization` header has valid crendentials' do
        before do
          subject.request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{session.authentication_token}\", user_email=\"#{user.email}\""
        end

        it 'successfully signs the user in' do
          expect{
            subject.send(:authenticate_user_from_token!)
          }.to change(subject, :user_signed_in?).from(false).to(true)
        end

      end

      context 'when `authorization` header has invalid crendentials' do
        before do
          subject.request.env['HTTP_AUTHORIZATION'] = "Token token=\"blablabla\", user_email=\"#{user.email}\""
        end

        it 'doesn\'t sign the user in' do
          expect{
            subject.send(:authenticate_user_from_token!)
          }.to_not change(subject, :user_signed_in?)
        end
      end

      context 'when `authorization` token doesn\'t belongs to the user' do
        let(:another_session) {create(:session)}
        before do
          subject.request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{another_session.authentication_token}\", user_email=\"#{user.email}\""
        end

        it 'doesn\'t sign the user in' do
          expect{
            subject.send(:authenticate_user_from_token!)
          }.to_not change(subject, :user_signed_in?)
        end

      end

    end

  end


 end