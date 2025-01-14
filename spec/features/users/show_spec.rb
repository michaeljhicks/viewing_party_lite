require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  before(:each) do
    @vp1 = ViewingParty.create!(movie_id: 111, duration: 190, date: Time.new(2022, 0o4, 12, 21, 0o0),
                                start_time: Time.new(2022, 0o4, 12, 21, 0o0))
    @vp2 = ViewingParty.create!(movie_id: 550, duration: 152, date: Time.new(2022, 0o4, 11, 20, 30),
                                start_time: Time.new(2022, 0o4, 11, 20, 30))
    @vp3 = ViewingParty.create!(movie_id: 314, duration: 154, date: Time.new(2022, 0o4, 14, 18, 30),
                                start_time: Time.new(2022, 0o4, 14, 18, 30))
    @user1 = User.create!(name: 'Mike', email: 'mike@example.com', password: 'test')
    visit login_form_path
    fill_in 'email', with: 'mike@example.com'
    fill_in 'password', with: 'test'
    click_button 'Submit'
    @user2 = User.create!(name: 'Gunnar', email: 'gunnar@example.com', password: 'test')
    @user5 = User.create!(name: 'Bruce', email: 'Bruce@example.com', password: 'test')
    @up1 = UserParty.create!(viewing_party: @vp1, user: @user1, host: true)
    @up2 = UserParty.create!(viewing_party: @vp1, user: @user2, host: false)
    @up5 = UserParty.create!(viewing_party: @vp2, user: @user5, host: true)
    @up6 = UserParty.create!(viewing_party: @vp2, user: @user1, host: false)

    visit dashboard_path
  end

  context 'data is displayed on page', :vcr do
    it 'shows user name on dashboard header' do
      expect(page).to have_content("#{@user1.name}'s Dashboard")
      expect(page).to_not have_content("#{@user2.name}'s Dashboard")
    end
    it 'has a button to Discover Movies', :vcr do
      expect(page).to have_button('Discover Movies')
      click_button('Discover Movies')
      expect(current_path).to eq(discover_index_path)
    end
    it 'has a section that lists viewing parties', :vcr do
      within '#viewing_parties' do
        expect(page).to have_content('Viewing Parties')
      end
    end
  end

  context 'Viewing Parties' do
    it 'has movie titles', :vcr do
      within '#viewing_parties' do
        within "##{@vp1.id}" do
          expect(page).to have_content('Scarface')
        end
        within "##{@vp2.id}" do
          expect(page).to have_content('Fight Club')
        end
      end
    end
    it 'has party date', :vcr do
      within '#viewing_parties' do
        within "##{@vp1.id}" do
          expect(page).to have_content('Date: 2022-04-12')
        end
        within "##{@vp2.id}" do
          expect(page).to have_content('Date: 2022-04-11')
        end
      end
    end
    it 'has party time', :vcr do
      within '#viewing_parties' do
        within "##{@vp1.id}" do
          expect(page).to have_content('Date: 2022-04-12')
        end
        within "##{@vp2.id}" do
          expect(page).to have_content('Date: 2022-04-11')
        end
      end
    end
    it 'has name of hosts and invitees', :vcr do
      within '#viewing_parties' do
        within "##{@vp1.id}" do
          expect(page).to have_content('Host: Mike')
          expect(page).to have_content('Invitee: Gunnar')
        end
        within "##{@vp2.id}" do
          expect(page).to have_content('Host: Bruce')
          expect(page).to have_content('Invitee: Mike')
        end
      end
    end
  end
end
