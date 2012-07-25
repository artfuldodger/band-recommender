require 'spec_helper'

describe Recommenders::User do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommenders::User.new(user) }
  let!(:other_users) do
    users = []
    21.times { users << FactoryGirl.create(:user) }
    users
  end

  describe '#recommendations' do
    it 'returns a list of 20 users' do
      recommender.recommendations.size.should == 20
    end

    it 'returns them ordered by similarity descending' do
      other_users.each { |other_user| other_user.stub(similarity: other_user.id) }
      recommender.recommendations.should == other_users.sort_by(&:id).reverse.first(20)
    end
  end
end