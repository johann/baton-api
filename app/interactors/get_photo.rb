# frozen_string_literal: true

class GetPhoto
  include Interactor

  def call
    filename = context.filename

    client = Aws::Client.new
    url = client.send_file(filename)
    context.url = url
  end

end
