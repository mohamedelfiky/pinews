require 'rails_helper'
require 'rack/test'


describe 'Users API' do
  let(:user) { create(:user, :admin) }
  let(:user_header) { {'Authorization' => user.create_new_auth_token.to_json}  }

  it 'sends a list of users' do
    create_list(:user, 10, :author)

    get '/api/v1/users'

    # test for the 200 status-code
    expect(response).to be_success

    # user page size = 5
    expect(json.count).to eq(5)
  end

  it 'retrieves a specific user' do
    get "/api/v1/users/#{user.id}"

    # test for the 200 status-code
    expect(response).to be_success

    # check that the user attributes are the same.
    expect(json['name']).to eq(user.name)
  end

  it 'should a create user' do
    user = attributes_for(:user)
    post '/api/v1/users/', {user: user}, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the user attributes are the same.
    expect(json['name']).to eq(user[:name])
  end



  it 'should a edit user' do
    user.name = 'name'
    put "/api/v1/users/#{user.id}", { user: user.attributes.except(:image) }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    expect(User.find(user.id).name).to eq(user.name)
  end


  it 'should a destroy user' do
    delete "/api/v1/users/#{user.id}", { }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    expect(User.find_by_id(user.id)).to eq(nil)
  end
end
