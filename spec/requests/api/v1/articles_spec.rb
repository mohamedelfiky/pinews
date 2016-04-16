require 'rails_helper'

describe 'Articles API' do
  let(:user) { create(:user, :admin) }
  let(:user_header) { user.create_new_auth_token }
  let(:article) { create(:article) }

  it 'sends a list of articles' do
    create_list(:article, 10)

    get '/api/v1/articles'

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json.count).to eq(10)
  end

  it 'retrieves a specific article' do
    get "/api/v1/articles/#{article.id}"

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['title']).to eq(article.title)
  end

  it 'should a create article' do
    article = attributes_for(:article)
    post '/api/v1/articles/', {article: article}, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the message attributes are the same.
    expect(json['title']).to eq(article[:title])
  end



  it 'should a edit article' do
    article.title = 'el fiky'

    put "/api/v1/articles/#{article.id}", { article: article.as_json }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    # ensure that private attributes aren't serialized
    expect(Article.find(article.id).title).to eq(article.title)
  end


  it 'should a destroy article' do
    delete "/api/v1/articles/#{article.id}", { }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    # ensure that private attributes aren't serialized
    expect(Article.find_by_id(article.id)).to eq(nil)
  end
end