require 'spec_helper'

describe "Posts Resource", type: :controller do
  describe "API" do

    describe "index" do
      FactoryGirl.create_list(:post, 10)
      get "/posts"

      expect response.to be_success
      expect(json['posts'].length).to eq(10)
    end

    describe "show" do
      post = FactoryGirl.create(:post)
      get "/posts/#{post.id}"

      expect response.to be_success
      expect(json['headline']).to eq(post.headline)
      expect(json['resolved']).to eq(nil)
    end
    
  end
end
