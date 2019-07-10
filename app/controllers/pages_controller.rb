class PagesController < ApplicationController
  def show
    @page = Page.find(params['id'])
    gon.page_id = @page.id
    # GetPageStatisticsJob.perform_now(@page)
    doc = Nokogiri::HTML(@page.body)
    result = Services::Seo::Head.new(doc).check
    publish(@page,result)
  end

  private

  def publish(page, result)
    return if result.empty?

    ActionCable.server.broadcast("page_#{page.id}", result)
  end
end
