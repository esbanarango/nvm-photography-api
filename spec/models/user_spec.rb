require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'has a valid factory' do
      expect(create(:user)).to be_valid
    end

    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_uniqueness_of(:email)}
    it { is_expected.to respond_to(:email) }

    describe 'Relations' do
      it { is_expected.to have_many(:sessions).dependent(:destroy) }
    end
  end

end
