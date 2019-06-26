require 'rails_helper'

RSpec.describe Services::HTTPClient do
  describe '#robots' do
    it 'returns text of robots.txt. if it exists' do
      client = Services::HTTPClient.new 'https://ya.ru'
      expect(client.robots).to_not be_nil
    end

    it 'return nil if get errors' do
      client = Services::HTTPClient.new 'ftp://ya.ru'
      expect(client.robots).to be_nil
    end
  end
end
