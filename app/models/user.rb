# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string(255)      default(""), not null
#  sign_in_count        :integer          default(0), not null
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  provider             :string(255)
#  uid                  :string(255)
#  facebook_token       :string(255)
#  authentication_token :string(255)
#  name                 :string(255)
#  avatar               :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  link                 :string(255)
#  password_digest      :string
#

class User < ActiveRecord::Base
  # Associations
  has_secure_password
  has_many :posts
  has_many :memberships
  has_many :interactions, foreign_key: 'origin_user_id'
  has_many :tents, through: :memberships
  has_many :subscriptions

  # Concerns
  include TokenAuthenticable

  # Callbacks
  after_create :create_memberships

  # Devise strategies
  devise :registerable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

  def create_memberships
    # @todo compare user email with sent invites to determine what to join
    home_tent = Tent.first
    self.tents << home_tent.and_descendants
  end

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
