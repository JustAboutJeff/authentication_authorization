get '/' do
  # render home page
  if logged_in?
    @users = User.all
  end
 #TODO: Show all users if user is signed in
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  erb :sign_in
end

post '/sessions' do
  if user = User.authenticate(params)
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/'
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect '/'
end
