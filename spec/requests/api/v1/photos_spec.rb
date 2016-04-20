require 'rails_helper'

describe 'photos API' do
  let(:user) { create(:user, :admin) }
  let(:user_header) { user.create_new_auth_token }
  let(:article) { create(:article) }
  let(:photo) { article.photos << FactoryGirl.build(:photo); article.photos.first }

  it 'sends a list of article photos' do
    article.photos << build_list(:photo, 10)

    get "/api/v1/articles/#{article.id}/photos"

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json.count).to eq(10)
  end

  it 'retrieve a specific photo' do
    get "/api/v1/articles/#{article.id}/photos/#{photo.id}"

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['title']).to eq(photo.title)
  end

  it 'should create article photo' do
    photo = attributes_for(:photo)
    photo[:article_id] = article.id
    post "/api/v1/articles/#{article.id}/photos", {photo: photo}, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['title']).to eq(photo[:title])
  end



  it 'should edit article photo' do
    photo.title = 'el fiky'

    put "/api/v1/articles/#{article.id}/photos/#{photo.id}", { photo: photo.as_json }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    # ensure that private attributes aren't serialized
    expect(Photo.find(photo.id).title).to eq(photo.title)
  end


  it 'should a destroy article photo' do
    delete "/api/v1/articles/#{article.id}/photos/#{photo.id}", { }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)


    # ensure that private attributes aren't serialized
    expect(Photo.find_by_id(photo.id)).to eq(nil)
  end
end