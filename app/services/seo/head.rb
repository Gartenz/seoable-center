class Services::Seo::Head
  VIEWPORT_RULE = { "width" => 'device-width', "initial-scale" => 1, "viewport-fit" => 'cover'}.freeze
  HEAD_CHECKS = %i[doctype charset title description viewport favicon]
  ERRORS = { doctype: ['Should have valid <!doctype html>'], charset: ['Should have valid <meta charset="utf-8">'],
             title: ["Should be less than 55 characters"], description: ["Should be less than 150 characters"],
             favicon: ['Is not provided', 'Should be image/png']}.freeze

  def initialize(doc)
    @doc = doc
    @result = {}
    @validator = Services::Seo::Validator.new
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
        errors << "Should have #{k}"
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
    @result[:viewport] = @validator.validate(errors) { errors.size.zero? }
  end

  def doctype
    @result[:doctype] = @validator.validate(ERRORS[:doctype], @doc.internal_subset.name) { @doc.internal_subset.html_dtd? }
  end

  def charset
    @result[:charset] = @validator.validate(ERRORS[:charset], @doc.meta_encoding) { @doc.meta_encoding == 'utf-8' }
  end

  def title
    @result[:title] = @validator.validate(ERRORS[:title], @doc.title) { @doc.title.length <= 55 }
  end

  def description
    @result[:description] = @validator.validate(ERRORS[:description], search_meta('description')[:content]) { search_meta('description')[:content].length <= 150 }
  end

  def favicon
    fav = @doc.at('head').at("link[rel='icon']")
    @result[:favicon] = @validator.validate([ERRORS[:favicon][0]]) { !fav.nil? }
    return unless @result[:favicon][:value]

    href = fav[:href]
    url =
      if !(href =~ /^\/\//).nil?
        href[2..-1]
      else
        href
      end
    @result[:favicon] = @validator.validate([ERRORS[:favicon][1]], url) { fav[:type] =='image/png' && !(fav[:href] =~ /.png$/).nil? }
  end
end
