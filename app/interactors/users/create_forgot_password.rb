# frozen_string_literal: true

module Users
  class CreateForgotPassword
    include Interactor

    def call
      code = context.code
      client = DynamicLink::Client.new
      context.short_link = client.create_forgot_link(code)
    end
  end
end