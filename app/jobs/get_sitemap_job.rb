class GetSitemapJob < ApplicationJob
  queue_as :sitemaps

  def perform(site, url, lastmod)
    sitemap = site.sitemaps.find_by(url: url)
    if sitemap && lastmod
      return if lastmod.to_datetime == sitemap.lastmod.to_datetime
    end

    sitemap_body = Services::HTTPClient.get url
    return if sitemap_body.nil?

    sitemap_body = ActiveSupport::Gzip.decompress(sitemap_body) if url =~ /.gz$/

    if sitemap
      sitemap.update!(body: sitemap_body, lastmod: lastmod)
    else
      site.sitemaps.create!(url: url, body: sitemap_body, lastmod:  lastmod)
    end

    document = Nokogiri(sitemap_body)
    if document.at('sitemapindex')
      make_sitemap_jobs(site, document)
    else
      make_page_jobs(site, document)
    end
  end

  private

  def make_sitemap_jobs(site, document)
    document.search('sitemap').each do |sitemap|
      sitemap_url = sitemap.at('loc').content
      sitemap_lastmod = sitemap.at('lastmod').content
      GetSitemapJob.perform_later(site, sitemap_url, sitemap_lastmod)
    end
  end

  def make_page_jobs(site, document)
    document.search('url').each do |sitemap|
      page_url = sitemap.at('loc').content
      page_lastmod = sitemap.at('lastmod').content
      GetPageJob.perform_later(site, page_url, page_lastmod)
    end
  end
end
