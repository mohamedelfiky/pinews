describe "Groups API" do

  let(:user) { FactoryGirl.create(:user, :admin) }
  let(:user_header) { user.create_new_auth_token }

  it 'sends a list of groups' do
    FactoryGirl.create_list(:group, 10)

    get '/api/v1/groups'


    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json.count).to eq(10)
  end


  it 'retrieves a specific group' do
    group = FactoryGirl.create(:group)

    get "/api/v1/groups/#{group.id}", {}, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['name']).to eq(group.name)

    # ensure that private attributes aren't serialized
    expect(json['private_attr']).to eq(nil)
  end
end
