require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  let(:user){ create :user }
  it 'serves languages' do
    create :language
    sign_in(user)
    get :index
    expect(JSON.parse(response.body).length).to eql(Language.count)
  end

  it 'serves language name' do
    create :language
    sign_in(user)
    get :index
    expect(JSON.parse(response.body).first['url']).to eql('/logos/lang.png')
  end

  it 'serves language url' do
    create :language
    sign_in(user)
    get :index
    expect(JSON.parse(response.body).first['name']).to eql('MyString')
  end

  it 'serves language suggestions' do
    create :suggestion
    sign_in(user)
    get :index
    expect(JSON.parse(response.body).first['suggestions'].first['title'])
      .to eql('Codelegy Programming Tutorial')
  end
end
