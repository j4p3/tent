require 'spec_helper'

describe "Posts Controller" do

    describe "#index action" do
      before do
        FactoryGirl.create_list(:post, 10)
      end

      
      it "lists posts" do
        get "/posts"
        response.should be_success
        expect(json['posts'].length).to eq(10)
      end
    end

    describe "#show action" do
      before do
        @post = FactoryGirl.create(:post)
      end

      it "shows a given post" do
        get "/posts/#{@post.id}"
        response.status.should eq(200)
        puts json
        expect(json['headline']).to eq(@post.headline)
        expect(json['resolved']).to eq(nil)
      end
    end
end
