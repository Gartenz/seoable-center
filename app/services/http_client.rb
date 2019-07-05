class Services::HTTPClient
  def self.get(url)
    response = Faraday.get url
    response.success? ? response.body : nil
  rescue StandardError
    nil
  end
end
