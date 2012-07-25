require 'spec_helper'

describe Recommenders::User do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommenders::User.new(user) }
  let!(:other_users) do
    users = []
    30.times { users << FactoryGirl.create(:user) }
    users
  end

  describe '#recommendations' do
    it 'returns a list of 20 users' do
      recommender.recommendations.size.should == 20
    end

    it 'returns them ordered by similarity descending' do
      pending 'computer dying, no power'
      other_users.each do |other_user|
        SimilarityCalculators::EuclideanDistance.any_instance.stub(:similarity).with(other_user).and_return(other_user.id)
      end
      recommender.recommendations.should == other_users.last(20)
    end
  end
end