require 'rails_helper'

feature 'Users can add sites', %q{
  In order to get information about this sites
  User must add it
} do
  background do
    visit root_path
  end

  scenario 'Add site with valid attributes' do
    url = 'https://yandex.ru'

    within '.new-site' do
      fill_in :Url, with: url
      click_on 'Add site'
    end

    expect(page).to have_content(url)
  end

  scenario 'Add site with invalid attributes' do
    within '.new-site' do
      fill_in :Url, with: nil
      click_on 'Add site'
    end

    expect(page).to have_content("Url can't be blank")
  end
end
