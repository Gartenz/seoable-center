class Page < ApplicationRecord
  belongs_to :site

  validates :body, :url, :lastmod, presence: true
end
