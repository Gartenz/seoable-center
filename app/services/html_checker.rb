module Services::SeoCheker
  class Head
    def self.parse(head)
      result = {}
      result[:doctype] = doc.internal_subset.html_dtd?
      result[:charset] = doc.meta_encoding == 'utf-8' ? true : false
      result[:viewport] = parse_viewport(head.at("meta[name='viewport']")[:content])
      result[:title] = doc.tittle.length <= 55 ? true : false
    end

    private

    def parse_viewport(viewport_string)
      params = viewport_string.split(',').map { |param| param.strip }
      hash_params = Hash[*params.map { |p| p.split('=') }.flatten]
      viewport_valid?(hash_params)
    end

    def viewport_valid?(params)
      return false unless params['width'] == 'device-width'
      return false unless params['initial-scale'].to_i == 1
      return false unless params['viewport-fit'] == 'cover'

      true
    end
  end
end
