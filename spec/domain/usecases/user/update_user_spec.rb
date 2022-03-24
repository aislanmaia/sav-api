# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module User
    describe UpdateUser do
      let(:user) { create(:user_technician) }

      let(:params) do
        {
          id: user.id,
          name: 'User 1',
          email: 'user1@email.com',
          registry: 123456789,
          password: '123456',
          user: logged_user
        }
      end
      context :admin do
        let(:logged_user) { create(:user_admin) }

        it 'should update with success when user is admin' do
          create(:client)

          result = ::UseCases::User::UpdateUser.new(params).call
          expect(result.success?).to be_truthy
        end
      end

      context :attendant do
        let(:logged_user) { create(:user_attendant) }

        it 'should update with success when user is attendant' do
          result = ::UseCases::User::UpdateUser.new(params).call
          expect(result.success?).to be_truthy
        end
      end

      context :technician do
        let(:logged_user) { create(:user_technician) }

        it 'should not permit update when user is technician' do
          result = ::UseCases::User::UpdateUser.new(params).call
          expect(result.failure?).to be_truthy
          expect(result.errors[:code]).to eq(403)
          expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
        end
      end
    end
  end
end
