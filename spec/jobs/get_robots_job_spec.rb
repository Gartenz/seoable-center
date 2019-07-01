require 'rails_helper'

RSpec.describe GetRobotsJob, type: :job do
  let!(:site) { create(:site) }
  let(:service) { double('Services::HTTPClient') }

  before do
    allow(Services::HTTPClient).to receive(:new).with(site.url).and_return(service)
  end

  it 'calls Services::HTTPClient#robots' do
    expect(service).to receive(:robots)
    GetRobotsJob.perform_now(site)
  end
end
