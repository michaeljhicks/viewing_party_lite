require 'rails_helper'

RSpec.describe 'create a new viewing party' do
  before(:each) do
    @user = User.create!(name: 'Jackie', email: 'jackie.brown@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Billy', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')
    @movie_id = 550

    visit '/'
    click_on 'Login'
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on 'Login'
    visit "/dashboard/movies/#{@movie_id}"
    click_on 'Create Viewing Party'
  end

  describe 'When vailid data is entered' do
    it 'Creates a viewing party ' do
      expect(page).to have_field(:duration, with: '139')

      within '#date' do
        select '2022'
        select 'May'
        select '12'
      end

      within '#_time_4i' do
        select '07'
      end

      within '#_time_5i' do
        select '00'
      end

      check :Billy
      click_on 'Create Viewing Party'

      viewing_party_id = ViewingParty.last.id
      expect(current_path).to eq(dashboard_path)

      within("#viewing-party-#{ViewingParty.last.id}") do
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('May 12, 2022')
        expect(page).to have_content('7:00')
        expect(page).to have_content('Hosting')
      end
    end

    it "the new viewing party will show up on an invited user's dashboard" do
      within '#date' do
        select '2022'
        select 'May'
        select '12'
      end

      within '#_time_4i' do
        select '07'
      end

      within '#_time_5i' do
        select '00'
      end

      check :Billy
      click_on 'Create Viewing Party'

      visit '/'
      click_on 'Login'
      fill_in :email, with: @user2.email
      fill_in :password, with: @user2.password
      click_button 'Login'

      within("#viewing-party-#{ViewingParty.last.id}") do
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('May 12, 2022')
        expect(page).to have_content('7:00')
        expect(page).to have_content('Invited')
      end
    end
  end
end
