describe 'v1/articles/index.jbuilder' do
  let!(:article) { create(:article) }
  let(:collection) { Article.page(1) }
  let(:json) { JSON.parse(rendered) }

  before do
    assign(:articles, collection)
    render
  end

  it { expect(view).to render_template('v1/articles/index') }
  it { expect(json).not_to be_empty }
end
