class Services::Seo::Validator
  def validate(errors, info=nil, &block)
    if yield
      param_valid(info)
    else
      param_invalid(errors, info)
    end
  end

  private

  def param_valid(info)
    { value: true, info: info, errors: [] }
  end

  def param_invalid(errors, info)
    { value: false, info: info, errors: errors }
  end
end
