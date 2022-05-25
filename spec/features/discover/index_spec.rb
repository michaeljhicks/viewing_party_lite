require 'rails_helper'

describe 'Discover Movies', type: :feature do
  before do
    @user1 = User.create!(name: "Billy", email: "billy.zane@gmail.com")
    @user2 = User.create!(name: "Johnny", email: "johnny.b@gmail.com")

    visit user_discover_index_path(@user1)
  end

  it 'Displays discover movie stuff' do
    expect(page).to have_content("Discover Movies")
  end
end
