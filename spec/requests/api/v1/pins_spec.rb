require 'rails_helper'

describe 'Article Pins API' do
  let(:user) { create(:user, :admin) }
  let(:user_header) { {'Authorization' => user.create_new_auth_token.to_json}  }
  let(:article) { create(:article) }
  let(:pin) { p = build(:pin); p.update_attributes({article_id: article.id, user_id: user.id}); p }
  let(:base_url) { "/api/v1/articles/#{article.id}/pins/" }

  it 'sends a list of article Pins' do
    article.pins << build_list(:pin, 2)

    get base_url

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json.count).to eq(2)
  end

  it 'count all pins for an article' do
    article.pins << build_list(:pin, 2)
    get base_url + 'count'

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['count']).to eq(article.pins.count)
  end

  it 'should pin an article ' do
    post base_url, {}, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['article_id']).to eq(article.id)
  end


  it 'should a destroy article pin' do
    delete base_url + pin.id.to_s, {},  user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    # ensure that private attributes aren't serialized
    expect(Pin.find_by_id(pin.id)).to eq(nil)
  end
end
