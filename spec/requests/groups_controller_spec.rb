# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe "Group", type: :request do

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
    lat: { type: :string, example: 'johann@baton.com' },
    long: { type: :string, example: 'johann' },
    location: { type: :string, example: 'West Hollywood' },
    coach: { type: :object, properties: user_schema },
    description: { type: :string, example: "cool group" },
    photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  # user_properties = {
  #   user: { type: :object, properties: user_schema }
  # }

  path '/api/groups' do
    get 'Get all the groups' do
      tags 'Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      response '200', 'groups found' do
        schema type: :array, items: { properties: group_schema }
        let!(:user) { create(:user) }
        let!(:group) { create(:group, coach: user) }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        run_test!
      end
    end
  end

  # TODO: Improve this test to check for user
  path '/api/groups/discover' do
    get 'Get all the groups youre not in' do
      tags 'Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      response '200', 'groups found' do
        schema type: :array, items: { properties: group_schema }
        let!(:user) { create(:user) }
        let!(:group) { create(:group, coach: user) }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        run_test!
      end
    end
  end

  path '/api/groups/{id}' do
    get 'Get a group' do
      tags 'Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'Group found' do
        schema type: :object, properties: group_schema
        let!(:user) { create(:user, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }

        run_test!
      end
    end
  end

  path '/api/groups/{id}' do
    patch 'Update a group' do
      tags 'Groups'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :group_data,
                in: :body,
                type: :object,
                properties: group_schema
      response '200', 'Group Updated' do
        schema type: :object, properties: group_schema
        let!(:user) { create(:user, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        let!(:group_data) do
          { group: {
            location: 'Lower East Side'
          } }
        end

        run_test!
      end
    end
  end

  path '/api/groups/{id}/members' do
    get 'Get a groups list of members' do
      tags 'Groups'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Group Members found' do
        schema type: :array, items: { properties: user_schema }
        let!(:user) { create(:user, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }

        run_test!
      end
    end
  end
end
