require 'rails_helper'

RSpec.describe ProfileLanguage, type: :model do
  let(:profile) { create(:profile) }
  let(:profile_language) { create(:profile_language) }

  context 'associations' do
    it 'should respond to profile' do
      expect(profile_language).to respond_to(:profile)
    end

    it 'should respond to language' do
      expect(profile_language).to respond_to(:language)
    end

    it 'should respond to difficulty' do
      expect(profile_language).to respond_to(:difficulty)
    end

    specify 'corresponding profile should NOT be destroyed with profile_languages' do
      profile_language.profile_id = profile.id
      expect{profile_language.destroy}.to change {Profile.count}.by(0)
    end
  end
end
