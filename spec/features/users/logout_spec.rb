require 'rails_helper'

RSpec.describe 'Logging out as a registered user' do
  before(:each) do
    @user = User.create!(name: 'Billy Zane', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on 'Login'

    visit '/'
  end

  context 'the landing page' do
    it 'does not show a register or login button' do
      expect(page).to_not have_button('Login')
      expect(page).to_not have_button('New user')
    end

    it 'has a logout button' do
      click_link 'Logout'

      expect(current_path).to eq('/')
      expect(page).to have_button('New user')
      expect(page).to have_button('Login')
    end
  end
end
