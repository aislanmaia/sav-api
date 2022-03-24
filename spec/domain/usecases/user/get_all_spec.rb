# frozen_string_literal: true

require 'rails_helper'

module UseCases
  module User
    describe GetAll do
      it 'should return all users when user is admin' do
        create(:client)
        user = create(:user_admin)
        result = ::UseCases::User::GetAll.new({ user: user }).call
        expect(result.success?).to be_truthy
      end

      it 'should return all users when user is attendant' do
        create(:user_admin)
        create(:user_attendant)
        user = create(:user_attendant)
        result = ::UseCases::User::GetAll.new({ user: user }).call
        expect(result.success?).to be_truthy
      end

      it 'should return a permission exception error when user is technician' do
        create(:user_admin)
        create(:user_attendant)
        logged_user = create(:user_technician)
        result = ::UseCases::User::GetAll.new({ user: logged_user }).call
        expect(result.success?).to be_falsey
        expect(result.errors[:code]).to eq(403)
        expect(result.errors[:error]).to be_kind_of(::Sav::Errors::PermissionDenied)
      end

    end
  end
end
