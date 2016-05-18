require 'rails_helper'
require 'rack/test'

describe 'Articles API' do
  let(:user) { create(:user, :admin) }
  let(:user_header) do
    { 'Authorization' => user.create_new_auth_token.to_json }
  end
  let(:article) { create(:article) }

  it 'sends a list of articles' do
    create_list(:article, 10)

    get '/api/v1/articles'

    # test for the 200 status-code
    expect(response).to be_success

    # article page size =5
    expect(json.count).to eq(5)
  end

  it 'retrieves a specific article' do
    get "/api/v1/articles/#{ article.id }"

    # test for the 200 status-code
    expect(response).to be_success

    # check that the article attributes are the same.
    expect(json['title']).to eq(article.title)
  end

  it 'should a create article' do
    article = attributes_for(:article)
    post '/api/v1/articles/', { article: article }, user_header

    # test for the 200 status-code
    expect(response).to be_success

    # check that the article attributes are the same.
    expect(json['title']).to eq(article[:title])
  end

  it 'should a edit article' do
    attributes = attributes_for(:article)
    put "/api/v1/articles/#{ article.id }", { article: attributes }, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    expect(Article.find(article.id).title).to eq(article.title)
  end

  it 'should a destroy article' do
    delete "/api/v1/articles/#{ article.id }", {}, user_header

    # test for the 204 status-code
    expect(response.status).to eql(204)

    expect(Article.find_by_id(article.id)).to eq(nil)
  end
end
