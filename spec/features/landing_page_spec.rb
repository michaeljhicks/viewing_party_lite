require 'rails_helper'

RSpec.describe 'The landing page' do
  before(:each) do
    @user1 = User.create!(name: 'Ted Danson', email: 'ted@gmail.com', password: 'teddy', password_confirmation: 'teddy')
    @user2 = User.create!(name: 'Roger Ales', email: 'roger@verizon.net', password: 'foxsucks', password_confirmation: 'foxsucks')
    @user3 = User.create!(name: 'Jon Stewart', email: 'jonnystu@gmail.com', password: 'jonny', password_confirmation: 'jonny')

    visit '/'
    click_on 'Login'
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_button 'Login'

    visit '/'
  end

  it 'has the name of the app' do
    expect(page).to have_content('Viewing Party Lite')
  end
  it 'has a link to register a new user' do
    click_button 'New User'
    expect(current_path).to eq('/register')
    expect(page).to have_content('Register a new User')
  end
  it 'has a list of all existing users' do
    expect(page).to have_content('Roger Ales: roger@verizon.net')
    expect(page).to have_content('Jon Stewart: jonnystu@gmail.com')
    expect(page).to have_content('Ted Danson: ted@gmail.com')
  end

  it 'has a link to the landing page' do
    click_link 'Landing Page'

    expect(current_path).to eq('/')
  end
end
