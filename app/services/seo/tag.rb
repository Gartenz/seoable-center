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
    @doc.search('a[target="_blank"]').each do |a|
      if a[:rel].nil?
        errors_count += 1
      else
        rels = a[:rel].split(' ')
        if !rels.include? 'noopener'
          errors_count += 1
        end
      end
    end
    @result[:noopener] = @validator.validate(["There #{errors_count} link without 'noopener' param"]) { errors_count.zero? }
  end
end
