# frozen_string_literal: true

class UploadPhoto
  include Interactor

  def call
    filename = context.filename
    data = context.data

    client = Aws::Client.new
    url = client.upload(filename, data)
    context.url = url
  end

end
