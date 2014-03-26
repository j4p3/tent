module TokenAuthentication
  extend ActiveSupport::Concern
 
  # Parts sourced from https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
 
  included do
    # This is our new function that comes before Devise's one
    # before_action :authenticate_user_from_token!
    # This is Devise's authentication
    # before_action :authenticate_user!

    before_action :process_user!
  end
 
  module ClassMethods
    # nop
  end

  private

  def process_user!
    user = header_uid && User.find(header_uid)
    sign_in user, store: false
  end

  # => Params: either query string user_email & authentication_token,
  #    or header X-AUTHENTICATION-TOKEN & X-AUTHENTICATION-EMAIL
  # => Action: authenticate and sign in a user
  def authenticate_user_from_token!
    email = params[:user_email].presence || header_email
    token = params[:authentication_token].presence || header_token
    user = email && User.find_by(email: email)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, token)
      # Do not store user. Requires token with every request.
      sign_in user, store: false
    end
  end

  # => Action: retrieve authentication_token from request header
  # => Returns: authentication_token
  def header_token
    if authentication_token = params[:authentication_token].blank? && request.headers["X-AUTHENTICATION-TOKEN"]
      params[:authentication_token] = authentication_token
    end
  end

  # => Action: retrieve user_email from request header
  # => Returns: user_email
  def header_email
    if user_email = params[:user_email].blank? && request.headers["X-AUTHENTICATION-EMAIL"]
      params[:user_email] = user_email
    end
  end

  def header_uid
    request.headers["UID"]
  end
end