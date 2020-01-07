# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe "Group", type: :request do

  # user_schema = {
  #   id: { type: :integer, example: 20 },
  #   email: { type: :string, example: 'johann@baton.com' },
  #   username: { type: :string, example: 'johann' },
  #   bio: { type: :string, example: 'running forever' },
  #   coach: { type: :boolean },
  #   photo: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  # }


  # t.string "title"
  # t.string "description"
  # t.decimal "lat"
  # t.decimal "long"
  # t.string "additional_info"
  # t.bigint "group_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.datetime "start_date"
  # t.string "location"
  # t.datetime "end_date"
  # t.string "distance"
  # t.integer "intensity"

  # :title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :group_id, :distance

  activity_schema = {
    id: { type: :integer, example: 20 },
    lat: { type: :string, example: 'johann@baton.com', 'x-nullable': true },
    long: { type: :string, example: 'johann', 'x-nullable': true },
    additional_info: { type: :string, example: 'johann', 'x-nullable': true },
    location: { type: :string, example: 'West Hollywood', 'x-nullable': true },
    start_date: { type: :string, example: 'West Hollywood', 'x-nullable': true },
    end_date: { type: :string, example: 'West Hollywood', 'x-nullable': true },
    group_id: { type: :integer, example: 20 },
    description: { type: :string, example: "cool group", 'x-nullable': true },
    title: { type: :string, example: 'http://www.example.com', 'x-nullable': true }
  }

  path '/api/groups/{id}/activities' do
    get 'Get all the Activities' do
      tags 'Activities'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'Activities found' do
        schema type: :array, items: { properties: activity_schema }
        let!(:user) { create(:user) }
        let!(:group) { create(:group, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        run_test!
      end
    end
  end

  path '/api/activities/discover' do
    get 'Get all the Activities youre not in' do
      tags 'Activities'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      response '200', 'Activities found' do
        schema type: :array, items: { properties: activity_schema }
        let!(:user) { create(:user) }
        let!(:group) { create(:group, coach: user) }
        let!(:activity) { create(:activity, :with_user, group: group) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        run_test! do |response|
          expect(activity.users.include?(user)).to be(false)
        end
      end
    end
  end

  path '/api/groups/{id}/activities' do
    post 'Create a new activity' do
      tags 'Activities'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :activity_data,
                in: :body,
                type: :object,
                properties: activity_schema
      response '200', 'Activity created' do
        schema type: :object, properties: activity_schema
        let!(:user) { create(:user, :coach, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        let!(:activity_data) do
          { activity: {
            location: 'Lower East Side',
            lat: '',
            long: '',
            additional_info: '',
            start_date: '',
            end_date: '',
            description: '',
            title: ''
          } }
        end
        run_test!
      end
    end
  end

  path '/api/groups/{id}/activities/{activity_id}' do
    patch 'Update an activity' do
      tags 'Activities'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :activity_id, in: :path, type: :string
      parameter name: :activity_data,
                in: :body,
                type: :object,
                properties: activity_schema
      response '200', 'Activity updated' do
        schema type: :object, properties: activity_schema
        let!(:user) { create(:user, :coach, username: "blarf") }
        let!(:group) { create(:group, :with_user, coach: user) }
        let!(:id) { group.id }
        let!(:Authorization) { "Bearer #{user.generate_jwt}" }
        let!(:activity) { create(:activity) }
        let!(:activity_id) { activity.id }
        let!(:activity_data) do
          { activity: {
            location: 'Lower East Side',
            lat: '',
            long: '',
            additional_info: '',
            start_date: '',
            end_date: '',
            description: '',
            title: ''
          } }
        end

        run_test!
      end
    end
  end
end
