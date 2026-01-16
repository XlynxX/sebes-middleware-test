module Gateway
  class TransactionsController < ApplicationController
    def create
      provider_response = provider_client.init_transaction(transaction_params)

      transaction_id = provider_response.dig(:body, "transaction_id")

      redirect_url = auth_transaction_url(transaction_id)

      render json: { redirect_url: redirect_url }
    end

    private

    def transaction_params
      params.permit(:amount, :currency, :id)
    end

    def provider_client
      @provider_client ||= ProviderClient.new
    end
  end
end
