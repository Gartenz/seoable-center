class Services::Seo::Validator
  def validate(errors, *info, &block)
    if yield
      param_valid(info)
    else
      param_invalid(errors)
    end
  end

  private

  def param_valid(info)
    { value: true, info: info, errors: [] }
  end

  def param_invalid(errors)
    { value: false, errors: errors }
  end
end
