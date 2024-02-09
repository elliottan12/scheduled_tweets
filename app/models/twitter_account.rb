require "x"

class TwitterAccount < ApplicationRecord
  has_many :tweets
  belongs_to :user

  validates :username, uniqueness: true

  def client
    x_credentials = {
      :api_key => Rails.application.credentials.dig(:twitter, :api_key),
      :api_key_secret => Rails.application.credentials.dig(:twitter, :api_secret),
      :access_token => token,
      :access_token_secret => secret
    }

    # Initialize an X API client with your OAuth credentials
    client = X::Client.new(**x_credentials)
    return client
  end
end