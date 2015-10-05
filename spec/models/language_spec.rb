require 'rails_helper'

RSpec.describe Language, type: :model do
  let(:myLang) { create :language}
  it 'should have a name' do
    expect(myLang.name).to eql("MyString")
  end
end
