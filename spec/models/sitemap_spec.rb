require 'rails_helper'

RSpec.describe Sitemap, type: :model do
  it { should belong_to :site }

  it { should validate_presence_of :body }
end
