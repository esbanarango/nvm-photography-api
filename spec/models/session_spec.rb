require 'rails_helper'

RSpec.describe Session, type: :model do

  describe 'Validations' do
    it 'has a valid factory' do
      expect(build(:session)).to be_valid
    end

    it { expect validate_uniqueness_of(:user).scoped_to(:authentication_token)}

    describe 'Relations' do
      it { is_expected.to belong_to(:user) }
    end
  end

  describe 'Callbacks' do

    let(:session) {build(:session)}

    it { expect(session).to callback(:generate_authentication_token).before(:create) }
    it { expect(session).to callback(:expire_old!).after(:create) }

  end

  describe 'Scopes' do

    describe '.active' do

      before do
        create_list(:session, 5, expires_at: Time.now + 2.days)
        Session.limit(2).update_all(expires_at: Time.now - 2.days)
      end

      it 'returns only the active sessions' do
        expect(Session.active.count).to eq(3)
      end

    end

    describe '.inactive' do

      before do
        create_list(:session, 5, expires_at: Time.now + 2.days)
        Session.limit(2).update_all(expires_at: Time.now - 2.days)
      end

      it 'returns only the inactive sessions' do
        expect(Session.inactive.count).to eq(2)
      end

    end

  end

  describe '#active?' do
    context 'when `expires_at` is greater than now' do
      let(:session) { create(:session, expires_at: Time.now + 2.days) }
      it 'returns true' do
        expect(session.active?).to be_truthy
      end
    end

    context 'when `expires_at` is equal or less than now' do
      let(:session) { create(:session, expires_at: Time.now - 2.days) }
      it 'returns false' do
        expect(session.active?).to be_falsy
      end
    end
  end

  describe '#expire_old!' do
    let(:user) { create(:user) }
    context 'when there are not inactive sessions' do
      before do
        create_list(:session, 5, user: user, expires_at: Time.now + 2.days)
      end
      it 'does not destroy any sessions' do
        expect {
          user.sessions.first.expire_old!
        }.to_not change(Session, :count)
      end
    end
    context 'when there are inactive sessions' do
      before do
        create_list(:session, 5, user: user, expires_at: Time.now + 2.days)
        Session.limit(2).update_all(expires_at: Time.now - 2.days)
      end
      it 'destroys the inactive sessions' do
        expect {
          user.sessions.first.expire_old!
        }.to change(Session, :count).by(-2)
      end
    end
  end

end
