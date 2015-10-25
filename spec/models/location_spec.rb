require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'Validations' do

    it 'has a valid factory' do
      expect(build(:location)).to be_valid
    end

    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_uniqueness_of(:city).scoped_to(:country) }

    describe 'Relations' do
      it { is_expected.to have_many(:photos) }
    end
  end
end
