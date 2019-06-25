require 'rails_helper'

feature 'User can see site info', %q{
  In order to see addtional info of added sites
  User can see this info
} do
  scenario 'User can move to site info page' do
    site = create(:site)
    visit site_path(site)

    expect(page).to have_current_path(site_path(site))
  end
  context 'Use can see information about http(s)' do
    scenario 'site using https' do
      site = create(:site)
      visit site_path(site)

      expect(page).to have_content('HTTPS: true')
    end

    scenario 'site does not using https' do
      site = create(:site, url: 'http://yandex.ru')
      visit site_path(site)

      expect(page).to have_content('HTTPS: false')
    end
  end

  context 'Use can see information about www' do
    scenario 'site using www' do
      site = create(:site, url: 'https://www.yandex.ru')
      visit site_path(site)

      expect(page).to have_content('WWW: true')
    end

    scenario 'site does not using www' do
      site = create(:site)
      visit site_path(site)

      expect(page).to have_content('WWW: false')
    end
  end
end
