class Services::Seo
  def initialize(page)
    @doc = Nokogiri::HTML(page.body)
    @result = {}
  end

  def check
    @result[:head] = Services::Seo::Head.new(@doc).check
    @result[:html] = Services::Seo::Html.new(@doc).check
    @result[:tags] = Services::Seo::Tag.new(@doc).check
    @result
  end
end
