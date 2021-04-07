module DynamicLink
  class Client
    API_ENDPOINT = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyAfz5AmOLpSy7oKe-xVyUb8-JaS3T8-T9E".freeze

    attr_reader :token

    def initialize
    end

    def create_link(link)
      url = "https://web-blond.vercel.app/activities/#{link}"
      req = request(params: 
      {
        "dynamicLinkInfo": {
          "domainUriPrefix": "baton-e55ff.firebaseapp.com",
          "link": url,
          "androidInfo": {
            "androidPackageName": "com.open.baton"
          },
          "iosInfo": {
            "iosBundleId": "com.open.baton"
          }
        }
      }
      )
      req
    end

    private
    def client 
      @_client ||= Faraday.new(API_ENDPOINT) do |client| 
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.headers['Content-Type'] = "application/json"
      end
    end

    def request(params: {})a
      response = client.post("", params.to_json)
      Oj.load(response.body)
    end
  end
end