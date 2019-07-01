class GetRobotsJob < ApplicationJob
  queue_as :robots

  def perform(site)
    body = Services::HTTPClient.new(site.url).robots
    site.create_robot(body: body)
  end
end
