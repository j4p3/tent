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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
