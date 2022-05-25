require 'rails_helper'
describe 'Creating a user' do
  before :each do
    visit '/register'

    @user = User.create!(name: 'Billy Zane', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')
  end

  context 'when valid data is entered' do
    it 'creates a user' do
      fill_in :name, with: 'Billy Zane'
      fill_in :email, with: 'billy.zaners@gmail.com'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_button 'Register'

      user = User.last
      expect(current_path).to eq(user_path(user))
    end
  end
  context 'when invalid data is entered' do
    it 'email must be unique' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'billy.zane@gmail.com'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_button 'Register'

      expect(page).to have_content('Notice: Email has already been taken')
      expect(page).to have_content('Register a new User')
    end

    it 'fields can not be blank' do
      fill_in :name, with: 'William'
      fill_in :password, with: 'Nice'
      fill_in :password_confirmation, with: 'Nice'
      click_button 'Register'

      expect(page).to have_content("Notice: Email can't be blank")
      expect(page).to have_content('Register a new User')
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
