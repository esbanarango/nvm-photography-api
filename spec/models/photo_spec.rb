require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'Validations' do

    it 'has a valid factory' do
      expect(build(:photo)).to be_valid
    end

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:image) }
  	it { is_expected.to validate_attachment_content_type(:image).
  												allowing('image/png', 'image/gif', 'image/jpeg').
                					rejecting('text/plain', 'text/xml') }

    describe 'Relations' do
      it { is_expected.to belong_to(:camara) }
    end
  end
end
