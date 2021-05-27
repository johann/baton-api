module OneSignal
  class Client
    API_ENDPOINT = "https://onesignal.com/api/v1".freeze
    APP_ID = "a82f16bd-6602-4d63-aa0a-cc4c81701d37".freeze

    attr_reader :token

    def initialize(token = ENV['ONE_SIGNAL_KEY'])
      @token = token
    end

    def send_push(title, ids = [])
      req = request(endpoint: "notifications", params: {"app_id": APP_ID, 
                                                  "include_external_user_ids": ids,
                                                  "contents": { "en": title}})
      req
    end

    private
    def client 
      @_client ||= Faraday.new(API_ENDPOINT) do |client| 
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.headers['Authorization'] = "Basic #{token}"
        client.headers['Content-Type'] = "application/json"
      end
    end

    def request(endpoint:, params: {})
      response = client.post(endpoint, params.to_json)
      Oj.load(response.body)
    end
  end
end