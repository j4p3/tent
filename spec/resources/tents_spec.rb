require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Tents' do
  let(:user) { create(:user) }

  get '/tents' do
    # @todo write some goddamn tests

  end

  get '/tent' do
    parameter :id, 'ID of tent to show'

    let(:id) { 1 }

    do_request
  end
end