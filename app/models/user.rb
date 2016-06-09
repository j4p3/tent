# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string           default(""), not null
#  sign_in_count        :integer          default(0), not null
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string
#  last_sign_in_ip      :string
#  provider             :string
#  uid                  :string
#  facebook_token       :string
#  authentication_token :string
#  name                 :string
#  avatar               :string
#  created_at           :datetime
#  updated_at           :datetime
#  link                 :string
#

class User < ActiveRecord::Base
  # Associations
  has_secure_password
  has_many :posts
  has_many :memberships
  has_many :tents, through: :memberships

  # Concerns
  include TokenAuthenticable

  # Devise strategies
  devise :registerable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

   # Override devise's password requirement (since we're using FB auth for now)
  def password_required?
    false
  end

  def self.from_facebook(auth)
    if new_user = User.find_by_email(auth.info.email)
      new_user.name = auth.info.name
      new_user.email = auth.info.email
      new_user.avatar = auth.info.image
      new_user.link = auth.link
      new_user.facebook_token = auth.credentials.token
      new_user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.avatar = auth.info.image
        user.link = auth.link
        user.facebook_token = auth.credentials.token
      end
    end
  rescue Exception => e
    raise e
  end
end
