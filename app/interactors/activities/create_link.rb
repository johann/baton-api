# frozen_string_literal: true

module Activities
  class CreateLink
    include Interactor

    def call
      activity = context.activity
      client = OneSignal::Client.new
      short_link = client.create_link(activity.id)
      activity.update(short_link: short_link)
    end
  end
end