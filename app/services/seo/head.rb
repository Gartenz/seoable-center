class Services::Seo::Head
  VIEWPORT_RULE = { "width" => 'device-width', "initial-scale" => 1, "viewport-fit" => 'cover'}.freeze
  HEAD_CHECKS = %i[doctype charset title description viewport favicon]
  def initialize(doc)
    @doc = doc
    @result = {}
  end

  def check
    HEAD_CHECKS.each { |check| send check }
    @result
  end

  private

  def search_meta(meta_name)
    @doc.at('head').search('meta').each do |meta|
      return meta if meta['name']&.downcase == meta_name
    end
  end

  def viewport
    params = search_meta('viewport')[:content].split(',').map { |param| param.strip }
    hash_params = Hash[*params.map { |p| p.split('=') }.flatten]
    errors = []
    VIEWPORT_RULE.each do |k,v|
      if !hash_params.keys.include? k
        errors << "viewport should have #{k}"
      else
        if k == 'initial-scale' && v!= hash_params[k].to_f
          errors << "Should have valid #{k}=#{v}"
        else
          if v != hash_params[k]
            errors << "Should have valid #{k}=#{v}"
          end
        end
      end
    end
    @result[:viewport] = errors.size.zero? ? param_valid : param_invalid(errors)
  end

  def doctype
    @result[:doctype] =
      if @doc.internal_subset.html_dtd?
        param_valid
      else
        param_invalid(['Should have valid <!doctype html>'])
      end
  end

  def charset
    @result[:charset] =
      if @doc.meta_encoding == 'utf-8'
        param_valid
      else
        param_invalid(['Should have valid <meta charset="utf-8">'])
      end
  end

  def title
    @result[:title] =
      if @doc.title.length <= 55
        param_valid
      else
        param_invalid(["Should be less than 55 characters"])
      end
  end

  def description
    @result[:description] =
      if search_meta('description')[:content].length <= 150
        param_valid
      else
        param_invalid(["Should be less than 150 characters"])
      end
  end

  def favicon
    fav = @doc.at('head').at("link[rel='icon']")
    if fav.nil?
      @result[:favicon] = param_invalid(['Favicon is not provided'])
      return
    end

    @result[:favicon] =
      if fav[:type] =='image/png' && !(fav[:href] =~ /.png$/).nil?
        param_valid
      else
        param_invalid(['Should be image/png'])
      end
  end

  def param_valid
    { value: true, errors: [] }
  end

  def param_invalid(errors)
    { value: false, errors: errors }
  end
end
