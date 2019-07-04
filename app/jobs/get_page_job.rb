class GetPageJob < ApplicationJob
  queue_as :pages

  def perform(site, url, lastmod)
    page_body = Services::HTTPClient.get url
    return if page_body.nil?

    site.pages.create!(url: url, body: page_body, lastmod: lastmod)
  end
end
