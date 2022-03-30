# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module User
    describe DeleteUser do
      it 'should delete client successfuly when user is admin' do
        user = create(:user_admin)
        subject = create(:user_technician)
        params = { id: subject.id, user: user }
        result = ::UseCases::User::DeleteUser.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should delete successfuly when user is attendant' do
        user = create(:user_attendant)
        user_target = create(:user_technician)
        params = { id: user_target.id, user: user }
        result = ::UseCases::User::DeleteUser.new(params).call
        expect(result.success?).to be_truthy
      end
      it 'should not permit delete if subject is admin' do
        user = create(:user_attendant)
        subject = create(:user_admin)
        params = { id: subject.id, user: user }
        result = ::UseCases::User::DeleteUser.new(params).call
        expect(result.failure?).to be_truthy
      end
      it 'should not permit delete when user is technician' do
        user = create(:user_technician)
        subject = create(:user_technician)
        params = { id: subject.id, user: user }
        result = ::UseCases::User::DeleteUser.new(params).call
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end
      it 'should not permit user delete himself' do
        user = create(:user_attendant)
        params = { id: user.id, user: user }
        result = ::UseCases::User::DeleteUser.new(params).call
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

