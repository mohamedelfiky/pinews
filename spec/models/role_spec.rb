require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { Role.new(name: 'Admin') }

  it 'validates uniqueness of name ' do
    is_expected.not_to be_valid
  end
end
