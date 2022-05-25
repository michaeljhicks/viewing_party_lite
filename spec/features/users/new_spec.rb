require 'rails_helper'

RSpec.describe 'Creating a user' do
  before(:each) do
    visit '/register'

    @user = User.create!(name: 'Billy Zane', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')
  end

  describe 'when valid data is entered' do
    it 'creates a user' do
      fill_in :name, with: 'Billy Zane'
      fill_in :email, with: 'billy.zaners@gmail.com'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_button 'Register'

      user = User.last
      expect(current_path).to eq(dashboard_path)
    end
  end
  describe 'when invalid data is entered' do
    it 'email must be unique' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'billy.zane@gmail.com'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_button 'Register'

      expect(page).to have_content('Notice: Email has already been taken')
      expect(page).to have_content('Register a new User')
    end

    it 'email field cant be blank' do
      fill_in :name, with: 'Billy'
      fill_in :password, with: 'Nice'
      fill_in :password_confirmation, with: 'Nice'
      click_button 'Register'

      expect(page).to have_content("Notice: Email can't be blank")
      expect(page).to have_content('Register a new User')
    end

    it 'name cant be empty' do
      fill_in :email, with: 'william.dafoe@gmail.com'
      fill_in :password, with: 'billy'
      fill_in :password_confirmation, with: 'billy'
      click_button 'Register'

      expect(page).to have_content("Notice: Name can't be blank")
      expect(page).to have_content("Register a new User")
    end

    it 'password can not be empty' do
      fill_in :name, with: 'Billy'
      fill_in :email, with: 'billy.zane@gmail.com'
      fill_in :password_confirmation, with: 'test'
      click_button 'Register'

      expect(page).to have_content("Notice: Password can't be blank")
      expect(page).to have_content("Register a new User")
    end

    it 'password confirmation cant be emty' do
      fill_in :name, with: 'Billy'
      fill_in :email, with: 'billy.zane@gmail.com'
      fill_in :password, with: 'test'
      click_button 'Register'

      expect(page).to have_content("Notice: Password confirmation doesn't match Password")
      expect(page).to have_content("Register a new User")
    end

    it 'passwords must match' do
      fill_in :name, with: 'Billy'
      fill_in :email, with: 'titanic@gmail.com'
      fill_in :password, with: 'kate'
      fill_in :password_confirmation, with: 'leo123'
      click_button 'Register'

      expect(page).to have_content("Notice: Password confirmation doesn't match Password")
      expect(page).to have_content('Register a new User')
    end
  end
end
