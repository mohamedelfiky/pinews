describe 'v1/users/show.jbuilder' do
  let!(:user) { create(:user, :author) }
  let(:json) { JSON.parse(rendered) }

  let(:expected_json_keys) do
    %w(id name nickname email articles role)
  end

  before do
    assign(:user, user)
    render
  end

  it { expect(view).to render_template('v1/users/show') }
  it { expect(json.keys).to match_array(expected_json_keys) }
end
