require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should belong_to :site }
  it { should have_many(:statistics).dependent(:destroy) }

  it { should validate_presence_of :body }
  it { should validate_presence_of :url }
  it { should validate_presence_of :lastmod }
end
