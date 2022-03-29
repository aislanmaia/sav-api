# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module User
    describe UpdateUser do
      let(:subject) { create(:user_technician) }

      let(:params) do
        {
          id: subject.id,
          firstname: 'User1',
          lastname: 'Last name',
          email: 'user1@email.com',
          registry: 123456789,
          password: '123456',
          user: logged_user
        }
      end
      
      context :admin do
        let(:logged_user) { create(:user_admin) }

        it 'should update with success when user is technician' do
          result = ::UseCases::User::UpdateUser.new(params).call
          expect(result.success?).to be_truthy
        end
        let(:subject) { create(:user_attendant) }

        it 'should update with success when user is attendant' do
          result = ::UseCases::User::UpdateUser.new(params).call
          expect(result.success?).to be_truthy
        end
      end

      context :attendant do
        let(:logged_user) { create(:user_attendant) }

        describe 'try to update an attendant' do
          let!(:subject) { create(:user_attendant) }
          it 'should update with success' do
            result = ::UseCases::User::UpdateUser.new(params).call
            expect(result.success?).to be_truthy
          end
        end
        describe 'try to update a technician' do
          let!(:subject) { create(:user_technician) }
          it 'should update with success' do
            result = ::UseCases::User::UpdateUser.new(params).call
            expect(result.success?).to be_truthy
          end
        end

        describe 'try to update a admin' do
          let(:subject) { create(:user_admin) }
          it 'should not permit update when subject is admin' do
            result = ::UseCases::User::UpdateUser.new(params).call
            expect(result.failure?).to be_truthy
          end
        end
      end

      context :technician do
        let(:logged_user) { create(:user_technician) }
        let(:subject) { create(:user_attendant) }

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
