# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'
require 'byebug'

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
    photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  path '/api/user/groups' do
    get 'Get all a of users groups' do
      tags 'Current User Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      response '200', 'groups found' do
        schema type: :array, items: { properties: group_schema }
        let!(:user) { create(:user, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:signed_user) { group.members.first }
        let!(:Authorization) { "Bearer #{signed_user.generate_jwt}" }

        run_test!
      end
    end
  end

  path '/api/user/groups' do
    post 'Join a group' do
      tags 'Current User Groups'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :group_data,
                in: :body,
                type: :object,
                properties: group_schema
      response '200', 'Group found' do
        let!(:user) { create(:user, username: "blarf") }
        let!(:group) { create(:group, coach: user) }
        let!(:signed_user) { create(:user) }
        let!(:Authorization) { "Bearer #{signed_user.generate_jwt}" }
        let!(:group_data) do
          { group_id: "#{group.id}" }
        end
        run_test!
      end
    end
  end

  path '/api/user/groups/{id}' do
    delete 'Leave a group' do
      tags 'Current User Groups'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      response '204', 'Group deleted' do
        let!(:user) { create(:user, username: 'blarf') }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:signed_user) { group.members.first }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{signed_user.generate_jwt}" }
        run_test!
      end
    end
  end
end
