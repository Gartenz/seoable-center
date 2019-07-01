class Robot < ApplicationRecord
  after_create :get_sitemaps

  belongs_to :site

  validates :body, presence: true

  private

  def get_sitemaps
    GetSitemapJob.perform_later(self.site)
  end
end
