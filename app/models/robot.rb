class Robot < ApplicationRecord
  belongs_to :site

  validates :body, presence: true
end
