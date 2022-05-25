require 'rails_helper'

RSpec.describe 'The User login page' do
  before(:each) do
    @user = User.create!(name: 'Billy Zane', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')

    visit '/login'
  end

  describe 'when valid data is given' do
    it 'redirects to the user dashboard page' do
      fill_in :email, with: 'billy.zane@gmail.com'
      fill_in :password, with: 'test'
      click_button 'Login'

      expect(current_path).to eq("/users/#{@user.id}")
    end
    it 'email is incorrect' do
      fill_in :email, with: '12454'
      fill_in :password, with: 'test'
      click_button 'Login'


      expect(page).to have_content("User Login")
      expect(page).to have_content("Notice: invalid email")
    end

    it 'password is incorrect' do
      fill_in :email, with: 'brylan.gannon@gmail.com'
      fill_in :password, with: 'test'
      click_button 'Login'

      expect(page).to have_content('User Login')
      # expect(page).to have_content('Notice: invalid password')
    end
  end
end
