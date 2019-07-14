class Services::Seo::Html

  def initialize(doc)
    @doc = doc
    @result = {}
    @validator = Services::Seo::Validator.new
  end

  def check
    lang
    direction
    @result
  end

  private

  def lang
    @result[:lang] = @validator.validate(['Is not provided'], @doc.at('html')['lang']) { @doc.at('html')['lang'] }
  end

  def direction
    @result[:direction] = @validator.validate(['Is not provided'], @doc.at('html')['dir']) { @doc.at('html')['dir'] }
  end
end
