require 'rails_helper'

RSpec.describe 'create a new viewing party' do
  before do
    @user = User.create!(name: 'Jackie', email: 'jackie.brown@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Billy', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')
    @movie_id = 550
    visit user_movie_path(@user,@movie_id)

    click_on 'Create Viewing Party'
  end

  context 'When vailid data is entered' do
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
      expect(current_path).to eq user_path(@user)

      within("#viewing-party-#{viewing_party_id}") do
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('May 12, 2022')
        expect(page).to have_content('7:00')
        expect(page).to have_content('Hosting')
      end

      visit user_path(@user2)

      within("#viewing-party-#{viewing_party_id}") do
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('May 12, 2022')
        expect(page).to have_content('7:00')
        expect(page).to have_content('Invited')
      end
    end
  end
end
