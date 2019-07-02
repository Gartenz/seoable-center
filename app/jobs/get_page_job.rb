class GetPageJob < ApplicationJob
  queue_as :pages

  def perform(site, url)
    page_body = Services::HTTPClient.get url
    return if page_body.nil?

    site.pages.create(body: page_body)
  end
end
