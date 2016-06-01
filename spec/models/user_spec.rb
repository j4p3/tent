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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
