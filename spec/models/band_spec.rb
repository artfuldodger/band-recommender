require 'spec_helper'

describe Band do
  it { should validate_presence_of :name }
  it { should have_many :ratings }
end
