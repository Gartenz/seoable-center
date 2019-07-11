class Page < ApplicationRecord
  belongs_to :site
  has_many :statistics, -> { order(created_at: :desc) }, dependent: :destroy

  validates :body, :url, :lastmod, presence: true
end
