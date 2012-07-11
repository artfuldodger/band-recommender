require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user) }

  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should validate_presence_of :name }
  it { should have_many :ratings }
  it { should have_attached_file :picture }
end
