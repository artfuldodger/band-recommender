require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.create(:user) }

  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should validate_presence_of :name }
  it { should have_many :ratings }
  it { should have_attached_file :picture }

  describe '#all_other_users' do
    it 'gets all other users' do
      other_users = [FactoryGirl.create(:user), FactoryGirl.create(:user)]
      user.all_other_users.should_not include user
      user.all_other_users.should =~ other_users
    end
  end

end
