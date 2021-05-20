module DynamicLink
  class Client
    API_ENDPOINT = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyAfz5AmOLpSy7oKe-xVyUb8-JaS3T8-T9E".freeze

    attr_reader :token

    def initialize
    end

    def create_link(activity)
      url = "https://web-blond.vercel.app/activities/#{activity.id}"
      req = request(params: 
      {
        "dynamicLinkInfo": {
          "domainUriPrefix": "batonapp.page.link",
          "link": url,
          "androidInfo": {
            "androidPackageName": "com.open.baton"
          },
          "iosInfo": {
            "iosBundleId": "com.open.baton"
          },
          "socialMetaTagInfo": {
            "socialTitle": activity.title,
            "socialDescription": activity.description,
            "socialImageLink": activity.photo
          }
        }
      }
      )
      if req["shortLink"]
        req["shortLink"]
      else
        req
      end
    end

    private
    def client 
      @_client ||= Faraday.new(API_ENDPOINT) do |client| 
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.headers['Content-Type'] = "application/json"
      end
    end

    def request(params: {})
      response = client.post("", params.to_json)
      Oj.load(response.body)
    end
  end
end