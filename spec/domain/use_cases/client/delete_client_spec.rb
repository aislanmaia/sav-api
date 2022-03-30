# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module Client
    describe DeleteClient do
      it 'should delete client successfuly when user is admin' do
        user = create(:user_admin)
        client = create(:client)
        params = { id: client.id, user: user }
        result = ::UseCases::Client::DeleteClient.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should delete client successfuly when user is attendant' do
        user = create(:user_attendant)
        client = create(:client)
        params = { id: client.id, user: user }
        result = ::UseCases::Client::DeleteClient.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should not permit delette client when user is technician' do
        user = create(:user_technician)
        client = create(:client)
        params = { id: client.id, user: user }
        result = ::UseCases::Client::DeleteClient.new(params).call
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

