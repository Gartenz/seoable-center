class Site < ApplicationRecord
  after_commit :get_robots, on: :create

  has_one :robot
  has_many :sitemaps, dependent: :destroy
  has_many :pages, dependent: :destroy

  validates :url, presence: true

  def https?
    !(self.url =~ URI::regexp('https')).nil?
  end

  def www?
    !(self.url =~ /\:\/{2}(w{3})\./).nil?
  end

  private

  def get_robots
    GetRobotsJob.perform_later(self)
  end
end
