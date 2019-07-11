class Statistic < ApplicationRecord
  belongs_to :page

  validates :body, presence: true
end
