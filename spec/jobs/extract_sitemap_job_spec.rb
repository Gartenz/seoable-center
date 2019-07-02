require 'rails_helper'

RSpec.describe ExtractSitemapJob, type: :job do
  let!(:site) { create(:site, robot: create(:robot)) }

  it 'calls GetRobotsJob#perform_later' do
    expect(GetRobotsJob).to receive(:perform_later)
    ExtractSitemapJob.perform_now(site)
  end
end
