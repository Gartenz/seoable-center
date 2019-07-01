require 'rails_helper'

RSpec.describe Site, type: :model do
  it { should have_one :robot }
  it { should have_many(:sitemaps).dependent(:destroy)  }

  it { should validate_presence_of :url }

  describe "#https?" do
    it 'returns true if url contain https protocol' do
      site = create(:site)
      expect(site.https?).to eq true
    end

    it 'returns false if url does not contain https protocol' do
      site = create(:site, url: 'http://yandex.ru')
      expect(site.https?).to eq false
    end
  end

  describe "#www?" do
    it 'returns true if url contains www domain' do
      site = create(:site, url: 'http://www.yandex.ru')
      expect(site.www?).to eq true
    end
    it 'returns false if url does not contains www domain' do
      site = create(:site, url: 'http://yandex.ru')
      expect(site.www?).to eq false
    end
  end
end
