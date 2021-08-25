# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe 'Group', type: :request do

  user_schema = {
    id: { type: :integer, example: 20 },
    email: { type: :string, example: 'johann@baton.com' },
    username: { type: :string, example: 'johann' },
    bio: { type: :string, example: 'running forever' },
    coach: { type: :boolean },
    photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  group_schema = {
    id: { type: :integer, example: 20 },
    lat: { type: :string, example: '23.2324' },
    long: { type: :string, example: '-12.234' },
    location: { type: :string, example: 'West Hollywood' },
    coach: { type: :object, properties: user_schema },
    description: { type: :string, example: 'cool group' },
    photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  path '/api/users/{username}/groups' do
    get 'Get all a specific users groups' do
      tags 'User Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :username, in: :path, type: :string
      response '200', 'groups found' do
        schema type: :array, items: { properties: group_schema }
        let!(:user) { create(:user, username: 'blarf') }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:username) { group.members.first.username }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }

        run_test!
      end
    end
  end
end