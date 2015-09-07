require 'rails_helper'

RSpec.describe Camara, type: :model do

  describe 'Validations' do

    it 'has a valid factory' do
      expect(build(:camara)).to be_valid
    end

    it { is_expected.to validate_presence_of(:model) }

    describe 'Relations' do
      it { is_expected.to have_many(:photos) }
    end
  end

end
