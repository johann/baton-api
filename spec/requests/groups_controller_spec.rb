# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'
require 'byebug'


# t.text "name"
# t.text "description"
# t.decimal "lat"
# t.decimal "long"
# t.bigint "user_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["user_id"], name: "inde

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

  path '/api/groups/{id}' do
    get 'Get a group' do
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

  path '/api/groups/{id}/members' do
    get 'Get a groups list of members' do
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
