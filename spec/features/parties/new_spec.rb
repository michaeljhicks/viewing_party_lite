require 'rails_helper'

RSpec.describe 'New party page' do
  it 'When i visit the new party page has title and form', :vcr do
    user_1 = User.create!(name: 'Mike', email: 'mike@example.com', password: 'test')
    visit login_form_path
    fill_in 'email', with: 'mike@example.com'
    fill_in 'password', with: 'test'
    click_button 'Submit'
    user_2 = User.create!(name: 'Gunnar', email: 'gunnar@example.com', password: 'test')
    movie_id = 22

    visit new_movie_viewing_party_path(movie_id)
    fill_in :duration, with: '102'
    fill_in :date, with: '3/23/2022'
    fill_in :start_time, with: '6:30'

    expect(page).to have_field('duration', with: 102)
    expect(page).to have_field('date')
    expect(page).to have_button('Create Party')
  end
end
