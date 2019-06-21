class Site < ApplicationRecord
  validates :url, presence: true

  def https?
    !(self.url =~ URI::regexp('https')).nil?
  end

  def www?
    !(self.url =~ /\:\/{2}(w{3})\./).nil?
  end
end
