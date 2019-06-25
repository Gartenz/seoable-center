class Services::GetRobots
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    connection = Faraday::Connection.new url
    response = connection.get 'robots.txt'
    return response.success? ? response.body : nil
  end
end
