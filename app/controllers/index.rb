

get '/' do
  if session[:id]
    @user = User.find(session[:id])
    erb :index
  else
    erb :index
  end
end

get '/sign_in' do
  # p request_token
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  # at this point in the code is where you'll need to create your user account and store the access token
  @user = User.find_or_create_by_username(username: @access_token.params[:screen_name],oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  session[:id] = @user.id
  erb :index
  
end

post "/tweetout" do
  p params
  @user = User.find(params[:user_id])
  Twitter.configure do |config|
    config.oauth_token = @user.oauth_token
    config.oauth_token_secret = @user.oauth_secret
  end
  Twitter.update(params[:text])
end


#yup
