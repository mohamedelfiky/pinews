describe 'v1/articles/show.jbuilder' do
  let!(:article) { create(:article) }
  let(:json) { JSON.parse(rendered) }

  let(:expected_json_keys) do
    %w(id title description created_at image author role photos)
  end

  before do
    assign(:article, article)
    render
  end

  it { expect(view).to render_template('v1/articles/show') }
  it { expect(json.keys).to match_array(expected_json_keys) }
end
