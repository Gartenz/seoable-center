class GetPageStatisticsJob < ApplicationJob
  queue_as :default

  def perform(page)
    result = {}
    result[:doctype] = (page.body =~ /^\<\!(DOCTYPE|doctype)\shtml\>/).zero? ? true : false

    doc = Nokogiri::HTML(page.body)
    result[:head] = parse_head(doc.at('head'))
  end

  private

  def parse_head(head)
    Services::SeoCheker.head(head)
  end
end
