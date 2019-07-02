class Robot < ApplicationRecord
  after_commit :get_sitemaps, on: :create

  belongs_to :site

  validates :body, presence: true

  private

  def get_sitemaps
    ExtractSitemapJob.perform_later(self.site)
  end
end
