class Services::Seo::Tag

  def initialize(doc)
    @doc = doc
    @result = {}
    @validator = Services::Seo::Validator.new
  end

  def check
    noopener
    @result
  end

  private

  def noopener
    errors_count = 0;
    error_links = []
    @doc.search('a[target="_blank"]').each do |a|
      if a[:rel].nil?
        errors_count += 1
        error_links << a[:href]
      else
        rels = a[:rel].split(' ')
        if !rels.include? 'noopener'
          error_links << a[:href]
          errors_count += 1
        end
      end
    end
    @result[:noopener] = @validator.validate(["There #{errors_count} link without 'noopener' param"], error_links) { errors_count.zero? }
  end
end
