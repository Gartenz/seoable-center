class Services::Seo::Html

  def initialize(doc)
    @doc = doc
    @result = {}
  end

  def check
    lang
    direction
    @result
  end

  private

  def lang
    @result[:lang] =
      if @doc.at('html')['lang']
        param_valid(@doc.at('html')['lang'])
      else
        param_invalid(['Is not provided'])
      end
  end

  def direction
    @result[:direction] =
      if @doc.at('html')['dir']
        param_valid(@doc.at('html')['dir'])
      else
        param_invalid(['Is not provided'])
      end
  end

  def param_valid(*info)
    { value: true, info: info, errors: [] }
  end

  def param_invalid(errors)
    { value: false, errors: errors }
  end
end
