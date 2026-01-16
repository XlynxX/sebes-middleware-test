class TransactionsController < ApplicationController
  def auth
    response = provider_client.authorize_transaction(params[:id])

    if response[:status] == 200 && response.dig(:body, "status") == "success"
      render plain: "success"
    else
      render plain: "failed", status: :unprocessable_entity
    end
  end

  private

  def provider_client
    @provider_client ||= ProviderClient.new
  end
end
