require 'rails_helper'

RSpec.describe Robot, type: :model do
  it { should validate_presence_of :body}
  it { should belong_to :site}
end
