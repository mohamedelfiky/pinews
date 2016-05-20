describe 'v1/pins/index.jbuilder' do
  let!(:pin) { create(:pin)  }
  let(:collection) { Pin.page(1) }
  let(:json) { JSON.parse(rendered) }

  before do
    assign(:pins, collection)
    assign(:article, pin.article)
    render
  end

  it { expect(view).to render_template('v1/pins/index') }
  it { expect(json).not_to be_empty }
end
