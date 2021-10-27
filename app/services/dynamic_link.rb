module DynamicLink
  class Client
    API_ENDPOINT = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=".freeze

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
            "socialImageLink": activity.photo_url
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

    def create_forgot_link(code)
      url = "https://batonapp.herokuapp.com/forgot-password?code=#{code}"
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
      endpoint = API_ENDPOINT + ENV['DYNAMIC_LINK_KEY']
      @_client ||= Faraday.new(endpoint) do |client|
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