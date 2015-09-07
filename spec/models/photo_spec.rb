require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'Validations' do

    it 'has a valid factory' do
      expect(build(:photo)).to be_valid
    end

    it { is_expected.to validate_presence_of(:description) }

    describe 'Relations' do
      it { is_expected.to belong_to(:camara) }
    end
  end
end
