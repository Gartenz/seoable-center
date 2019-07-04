class ExtractSitemapJob < ApplicationJob
  queue_as :default

  def perform(site)
    sitemaps = site.robot.body.scan(/Sitemap\:\s(?<url>.+)/)&.flatten.uniq
    if sitemaps.count.zero?
      GetSitemapJob.perform_later("#{site.url}/sitemap.xml")
    else
      sitemaps.each { |url| GetSitemapJob.perform_later(site, url, nil) }
    end
  end
end
