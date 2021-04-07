# frozen_string_literal: true

class GetPhoto
  include Interactor

  def call
    filename = context.filename

    client = Aws::Client.new
    url = client.send_file(filename)
    puts url
    context.url = url
  end

end

# User.all.each { |u| GetPhoto.call(filename: "users/#{u.id}").tap { |c| puts c.url } }