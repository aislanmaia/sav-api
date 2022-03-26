# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module User
    describe CreateUser do
      it 'should create with success when user is admin' do
        logged_user = create(:user_admin)

        params = {
          name: 'User 1',
          email: 'user1@email.com',
          registry: 123456789,
          password: '123456',
          user: logged_user
        }
        # params = build(:client).as_json.merge(user: user)
        result = ::UseCases::User::CreateUser.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should create with success when user is attendant' do
        logged_user = create(:user_attendant)
        params = {
          name: 'User 1',
          email: 'user1@email.com',
          registry: 123456789,
          password: '123456',
          user: logged_user
        }
        # params = build(:client).as_json.merge(user: user)
        result = ::UseCases::User::CreateUser.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should not permit create when user is technician' do
        logged_user = create(:user_technician)

        params = {
          name: 'User 1',
          email: 'user1@email.com',
          registry: 123456789,
          password: '123456',
          user: logged_user
        }
        # params = build(:client).as_json.merge(user: user)
        result = ::UseCases::User::CreateUser.new(params).call
        expect(result.failure?).to be_truthy
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end
    end
  end
end
