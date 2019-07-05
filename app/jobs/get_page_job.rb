class GetPageJob < ApplicationJob
  queue_as :pages

  def perform(site, url, lastmod)
    page = site.pages.find_by(url: url)
    if page
      return if lastmod.to_datetime == page.lastmod.to_datetime
    end

    page_body = Services::HTTPClient.get url
    return if page_body.nil?

    if page
      page.update!(body: page_body, lastmod: lastmod)
    else
      site.pages.create!(url: url, body: page_body, lastmod: lastmod)
    end
  end
end
