class UpdateSiteJob < ApplicationJob
  queue_as :default

  def perform(site)
    GetRobotsJob.perform_now(site, true)
    ExtractSitemapJob.perform_later(site)
  end
end
