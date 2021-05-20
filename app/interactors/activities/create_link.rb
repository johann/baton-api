# frozen_string_literal: true

module Activities
  class CreateLink
    include Interactor

    def call
      activity = context.activity
      client = DynamicLink::Client.new
      short_link = client.create_link(activity)
      activity.update(short_link: short_link)
    end
  end
end