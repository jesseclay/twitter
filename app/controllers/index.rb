get '/' do
  # Look in app/views/index.erb
  erb :index
end

# this works when we pass it in a username to the url
# get '/:username' do 
#   p "these are the params #{params[:username]}"
#   erb :index
# end

get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user.nil?
    @user = TwitterUser.create(username: params[:username])
  end
  if @user.tweets.empty? || @user.tweets_stale?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table 
    # instead of making an API call
    @user.fetch_tweets!
  end
  @twatter = @user.username
  @tweets = @user.tweets.order(:created_at).limit(10)
  erb :show_tweets
end

# get '/whatever' do 
#  erb :_name
# end
