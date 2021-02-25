# frozen_string_literal: true
require 'fog/aws'

class UploadPhoto
  include Interactor

  def call
    filename = context.filename
    data = context.data
    client = Aws::Client.new
    url = client.upload(filename, data)
    context.url = url
  end

  class Client
    BUCKET_NAME = "baton-app-images".freeze

    def initialize
    end

    def upload(filename, body)
      image_data = split_base64(body)
      image_data_string = image_data[:data]
      image_data_binary = Base64.decode64(image_data_string)
      extension = image_data[:extension]
      name = "#{filename}.#{extension}"
      directory = client.directories.get(BUCKET_NAME)
      directory.files.create(key: filename, body: image_data_binary)
      url = send_file(filename)
      puts url
      url
    end

    def send_file(filename)
      directory = client.directories.get(BUCKET_NAME)
      file = directory.files.find { |f| f.key == filename }
      if file
        directory.files.new(key: filename).url(Time.now + 60)
      else
        nil
      end
    end
   
    def client 
      credentials = {
        aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
        aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
        region: "us-east-1",
        provider: "AWS"
      }
      @_client ||= Fog::Storage.new(credentials)
    end

    def split_base64(uri_str)
		  if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
		    uri = Hash.new
		    uri[:type] = $1 # "image/gif"
		    uri[:encoder] = $2 # "base64"
		    uri[:data] = $3 # data string
		    uri[:extension] = $1.split('/')[1] # "gif"
		    return uri
		  else
		    return nil
		  end
    end
  end

end
