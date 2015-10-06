require 'rails_helper'

RSpec.describe ProjectLanguage, type: :model do
  let(:pl){ create :project_language }
  it 'has a project association' do
    expect(pl.project).to be_a(Project)
  end

  it 'has a language association' do
    expect(pl.language).to be_a(Language)
  end
end
