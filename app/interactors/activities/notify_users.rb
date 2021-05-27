# frozen_string_literal: true

module Activities
  class NotifyUsers
    include Interactor

    def call
      activity = context.activity
      user_ids = activity.user_ids
      client = OneSignal::Client.new

      client.send_push("#{activity.group.title} just added a new activity! 🏃‍♀️", user_ids) if context.created
      client.send_push("#{activity.title} has been cancelled", user_ids) if context.cancelled
      client.send_push("#{activity.title} has been updated", user_ids) if context.updated
    end

  end
end
