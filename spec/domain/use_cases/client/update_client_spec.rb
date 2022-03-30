# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module Client
    describe UpdateClient do
      let(:client) { create(:client) }

      let(:params) do
        {
          id: client.id,
          name: 'Novo nome',
          email: 'novo@email.com',
          phone: '99999999',
          address: {
            street: 'Rua A',
            number: '999',
            neighborhood: 'Bairro A',
            city: 'Cidade Z',
            uf: 'UF'
          },
          user: user
        }
      end
      context :admin do
        let(:user) { create(:user_admin) }

        it 'should update with success when user is admin' do
          create(:client)

          result = ::UseCases::Client::UpdateClient.new(params).call
          expect(result.success?).to be_truthy
        end
      end

      context :attendant do
        let(:user) { create(:user_attendant) }

        it 'should update with success when user is attendant' do
          result = ::UseCases::Client::UpdateClient.new(params).call
          expect(result.success?).to be_truthy
        end
      end

      context :technician do
        let(:user) { create(:user_technician) }

        it 'should not permit update client when user is technician' do
          result = ::UseCases::Client::UpdateClient.new(params).call
          expect(result.failure?).to be_truthy
          expect(result.errors[:code]).to eq(403)
          expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
        end
      end
    end
  end
end
