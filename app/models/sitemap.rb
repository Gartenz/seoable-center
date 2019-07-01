class Sitemap < ApplicationRecord
  belongs_to :site

  validates :body, :url, presence: true
end
