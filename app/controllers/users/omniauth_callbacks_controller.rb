class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.from_facebook(request.env['omniauth.auth'])

    if user.persisted?
      # returning user
      complete_callback(user)
    else
      # new user
      new_user = User.create(user)
      if new_user.save
        # with valid credentials
        complete_callback(user)
      else
        # with invalid credentials
        # throw Exception
        logger.debug "Invalid user from facebook"
      end
    end
  end

  protected

  def complete_callback(user)
    # Log in and redirect user's browser to clientside app with token information.
    sign_in user, store: false
    redirect_to Tent::Application.config.clients.url
  end
end