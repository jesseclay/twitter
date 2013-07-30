class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    self.tweets.destroy
    tweet_objects = Twitter.user_timeline(self.username)
    tweet_objects.each do |tweet|
      self.tweets.create(content: tweet.text)
    end
  end

  def tweets_stale?
    if self.tweets.last.created_at + (15 * 60) > Time.now
      return false
    else
      true
    end
  end
end
