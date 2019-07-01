class Site < ApplicationRecord
  after_create :get_robots

  has_one :robot

  validates :url, presence: true

  def https?
    !(self.url =~ URI::regexp('https')).nil?
  end

  def www?
    !(self.url =~ /\:\/{2}(w{3})\./).nil?
  end

  private

  def get_robots
    GetRobotsJob.perform_later self
  end
end
