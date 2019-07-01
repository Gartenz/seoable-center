class GetSitemapJob < ApplicationJob
  queue_as :sitemap

  def perform(site, url)
    sitemap_body = Services::HTTPClient.get url
    return if sitemap_body.nil?
    
    site.sitemaps.create(url: url, body: sitemap_body)
    document = Nokogiri(sitemap)
    if document.at('sitemapindex')
      document.search('loc').each { |sitemap| GetSitemapJob.perform_later(site, sitemap.content) }
    else
      document.search('loc').each { |page| GetPageJob.perform_later(site, page.content) }
    end
  end
end
