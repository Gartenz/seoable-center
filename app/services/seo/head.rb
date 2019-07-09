class Services::Seo::Head
  VIEPORT_RULE = { "width" => 'device-width', "initial-scale" => 1, "viewport-fit" => 'cover'}.freeze

  def self.parse(head)
    result = {}
    result[:doctype] = parse_doctype
    result[:charset] = parse_charset
    result[:viewport] = parse_viewport(head.at("meta[name='viewport']")[:content])
    result[:title] = parse_title
    result[:description] = parse_desription(head.at("meta[name='description']")[:content])
  end

  private

  def parse_viewport(viewport_string)
    result = { value: true, errors: [] }
    params = viewport_string.split(',').map { |param| param.strip }
    hash_params = Hash[*params.map { |p| p.split('=') }.flatten]
    hash_params.each do |k,v|
      if k == 'initial-scale' && v.to_i != VIEPORT_RULE[k]
        result[:value] = false
        result[:errors] << ["Should have valid #{k}=#{VIEPORT_RULE[k]}"]
      else
        if v != VIEPORT_RULE[k]
          result[:value] = false
          result[:errors] << ["Should have valid #{k}=#{VIEPORT_RULE[k]}"]
        end
      end
    end
    result
  end

  def parse_doctype
    if doc.internal_subset.html_dtd?
      { value: true, errors: [] }
    else
      { value: false, errors: ['Should have valid <!doctype html>'] }
    end
  end

  def parse_charset
    if doc.meta_encoding == 'utf-8'
      { value: true, errors: [] }
    else
      { value: false, errors: ['Should have valid <meta charset="utf-8">'] }
    end
  end

  def parse_title
    result = { value: true, errors: [] }
    if doc.tittle.length > 55
      result[:value] = false
      result[:errors] << ["Should be less than 55 characters"]
    end
    result
  end

  def parse_desription(description_string)
    result = { value: true, errors: [] }
    if description_string.length > 150
      result[:value] = false
      result[:errors] << ["Should be less than 150 characters"]
    end
    result
  end
end
