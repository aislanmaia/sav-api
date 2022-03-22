# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it 'is valid when required fields are present and email is unique' do
    user = User.new(
      username: 'User 1',
      email: 'user1@email.com',
      role: 1,
      password: '123456'
    )
    expect(user).to be_valid
  end
  it 'is not valid when email is not unique' do
    User.create(
      username: 'User 1',
      email: 'user1@email.com',
      role: 1,
      password: '123456'
    )
    expected_user = User.new(
      username: 'Expected User',
      email: 'user1@email.com',
      role: 1,
      password: '123456'
    )
    expect(expected_user).to be_invalid
  end
end
