class GetRobotsJob < ApplicationJob
  queue_as :robots

  def perform(site, update = false)
    body = Services::HTTPClient.get "#{site.url}/robots.txt"
    if update
      site.robot.update(body: body)
    else
      site.create_robot(body: body)
    end
  end
end
