class Services::HTTPClient
  attr_reader :url, :robots, :connection

  def initialize(url)
    @url = url
    @connection = Faraday::Connection.new url
  end

  def robots
    response = connection.get 'robots.txt'
    @robots = response.success? ? response.body : nil
  rescue StandardError
    @robots = nil
  end

  def self.get(url)
    response = Faraday.get url
    response.success? ? response.body : nil
  rescue StandardError
    nil
  end
end
