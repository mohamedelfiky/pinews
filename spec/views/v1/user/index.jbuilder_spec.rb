describe 'v1/users/index.jbuilder' do
  let!(:user) { create(:user, :author) }
  let(:collection) { User.page(1) }
  let(:json) { JSON.parse(rendered) }

  before do
    assign(:users, collection)
    render
  end

  it { expect(view).to render_template('v1/users/index') }
  it { expect(json).not_to be_empty }
end
