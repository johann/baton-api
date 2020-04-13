# frozen_string_literal: true

module Users
  class CreateFacebookUser
    include Interactor

    def call
      user = User.new(full_name: context.name, email: context.email, username: username, facebook_linked: true, facebook_data: context.to_h)
      user.skip_password_validation = true
      user.save!
      user.photo.attach(io: image_data, filename: username)
      context.user = user
    end

    private

    def image_data
      URI.open(context.picture[:data][:url])
    end

    def username
      context.email[/[^@]+/]
    end
  end
end
