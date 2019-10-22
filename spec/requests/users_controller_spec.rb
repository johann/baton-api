# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'
require 'byebug'

describe "User", type: :request do

  user_schema = {
    id: { type: :integer, example: 20 },
    email: { type: :string, example: 'johann@baton.com' },
    username: { type: :string, example: 'johann' },
    bio: { type: :string, example: 'running forever' },
    coach: { type: :boolean },
    photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  user_properties = {
    user: { type: :object, properties: user_schema }
  }

  path '/api/users/{username}' do
    get 'Get a users profile username' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :username, in: :path, type: :string
      response '200', 'account found' do
        schema type: :object, properties: user_properties
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        let!(:username) { "johann" }
        let!(:user) { create(:user, username: username) }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['user']['username']).to eq(username)
        end
      end
    end
  end

  path '/api/users/{id}' do
    patch 'Update a user account' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :user_data,
                in: :body,
                type: :object,
                properties: user_properties
      response '200', 'account found' do
        schema type: :object, properties: user_properties
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        let!(:user) { create(:user) }
        let!(:id) { user.id }
        let!(:user_data) do
          { user: {
              username: 'johannnkerrs',
              bio: 'blorp',
              coach: true
          } }
        end
        run_test!
      end
    end
  end
end
