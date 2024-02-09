class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    # Rescheduled a tweet to the future 
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end

# Push the publish_at forward 
# noon -> 8am
# - 
# 8am -> sets tweet id
# noon -> Sees that it's published, does nothing 

# Push the publish_at backward
# 9am -> 1pm
# - 
# 9am -> should do nothing. When we update the time, the publish_at of the tweet changes.
# So if the tweet's new publish at is at 1pm, it will run the job at 9am and see that the
# publish_at is at 1pm which is greater than the current time and return nothing. 
# 1pm -> should publish the tweet and set the tweet id