class ProviderClient
  PROVIDER_BASE_URL = "https://provider.example.com"

  def init_transaction(payload)
    response = connection.post("/transactions/init", payload.to_json)
    parse_response(response)
  end

  def authorize_transaction(transaction_id)
    response = connection.put("/transactions/auth/#{transaction_id}")
    parse_response(response)
  end

  private

  def connection
    @connection ||= Faraday.new(url: PROVIDER_BASE_URL) do |f|
      f.request :json
      f.response :json, content_type: "application/json"
      f.adapter Faraday.default_adapter
    end
  end

  def parse_response(response)
    {
      status: response.status,
      body: response.body
    }
  end
end
