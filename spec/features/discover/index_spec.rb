require 'rails_helper'

RSpec.describe 'Discover Movies', type: :feature do
  before(:each) do
    @user1 = User.create!(name: "Billy", email: "billy.zane@gmail.com", password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: "Johnny", email: "johnny.b@gmail.com", password: 'test', password_confirmation: 'test')
    visit '/'
    click_on 'Login'
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    visit dashboard_discover_path
  end

  it 'Displays a header' do
    expect(page).to have_content("Discover Movies")
  end

  it 'displays a top movies button that routes to the discover page' do
    click_button 'Top Rated Movies'

    expect(current_path).to eq(dashboard_movies_path)
  end

  it 'displays a search bar to find movies by keyword' do
    fill_in :query, with: 'Mad'
    click_button 'Search by Title'

    expect(current_path).to eq(dashboard_movies_path)
  end
end
