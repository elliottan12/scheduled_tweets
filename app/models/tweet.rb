class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do 
    self.publish_at ||= 24.hours.from_now
  end

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    tweet_id? 
  end

  def publish_to_twitter!
    # Construct the tweet body
    tweet_body = { text: body }.to_json

    # binding.irb # A debuggibg tool in rails console
    # Post the tweet using x_client
    tweet = twitter_account.client.post("tweets", tweet_body)

    # Update the tweet_id attribute with the ID of the posted tweet
    update(tweet_id: tweet["data"]["id"])
  end
end