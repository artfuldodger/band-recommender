require 'spec_helper'

describe Recommenders::User do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommenders::User.new(user) }

  before do
    30.times { FactoryGirl.create(:user) }
  end

  describe '#recommendations' do
    it 'returns a list of 20 users' do
      recommender.recommendations.size.should == 20
    end
  end
end