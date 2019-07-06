class DestroySiteJob < ApplicationJob
  queue_as :default

  def perform(site)
    site.pages.in_batches.destroy_all
    site.sitemaps.in_batches.destroy_all
    site.destroy
  end
end
