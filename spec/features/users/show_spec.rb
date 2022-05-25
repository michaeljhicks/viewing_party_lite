require 'rails_helper'
RSpec.describe 'User dashboard' do
  before(:each) do
    @user1 = User.create!(name: 'Billy', email: 'billy.zane@gmail.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Jackie', email: 'jackie.joyner112@gmail.com', password: 'test', password_confirmation: 'test')

    @vp1 = ViewingParty.create!(date: '2022/05/11', start_time: '12:00', duration: 120, movie_title: 'Star Wars')
    @vp1a = ViewingParty.create!(date: '2022/05/11', start_time: '15:00', duration: 120, movie_title: 'Star Wars Empire Strikes Back')

    @vp2 = ViewingParty.create!(date: '2022/05/11', start_time: '12:00', duration: 120, movie_title: 'The Godfather')

    @user1.party_users.create!(viewing_party_id: @vp1.id, host: true )
    @user1.party_users.create!(viewing_party_id: @vp1a.id, host: true )
    @user2.party_users.create!(viewing_party_id: @vp2.id, host: true )
    @user2.party_users.create!(viewing_party_id: @vp1.id, host: false )
    visit '/'
    click_on 'Login'
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_on 'Login'
    visit dashboard_path
  end
  it 'Displays user dashboard attributes on the page' do
    expect(page).to have_content("Billy's dashboard")
    expect(page).to_not have_content("Jackie's dashboard")
    expect(page).to have_button('Discover Movies')
    expect(page).to have_content('Viewing Parties')
  end
  it 'Displays viewing parties for the user' do
    within "#viewing-party-#{@vp1.id}" do
      expect(page).to have_content('Star Wars')
      expect(page).to have_content('May 11, 2022')
      expect(page).to have_content('12:00')
    end

    within "#viewing-party-#{@vp1a.id}" do
      expect(page).to have_content('Star Wars Empire Strikes Back')
      expect(page).to have_content('May 11, 2022')
      expect(page).to have_content('15:00')
    end

    expect(page).to_not have_css("#viewing-party-#{@vp2.id}")
  end
end
