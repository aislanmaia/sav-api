# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module Client
    describe CreateClient do
      it 'should create with success when user is admin' do
        create(:client)
        user = create(:user_admin)
        params = build(:client).as_json.merge(user: user)
        result = ::UseCases::Client::CreateClient.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should create with success when user is attendant' do
        create(:client)
        user = create(:user_attendant)
        params = build(:client).as_json.merge(user: user)
        result = ::UseCases::Client::CreateClient.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should not permit create client when user is technician' do
        create(:client)
        user = create(:user_technician)
        params = build(:client).as_json.merge(user: user)
        result = ::UseCases::Client::CreateClient.new(params).call
        expect(result.failure?).to be_truthy
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end
    end
  end
end
