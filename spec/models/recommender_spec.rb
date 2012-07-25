require 'spec_helper'

describe Recommender do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommender.new(user) }

  describe '#all_other_users' do
    it 'gets all other users' do
      other_users = [FactoryGirl.create(:user), FactoryGirl.create(:user)]
      recommender.all_other_users.should_not include user
      recommender.all_other_users.should =~ other_users
    end
  end

  describe '#rated_band_ids' do
    it 'returns all ids of the bands rated by the user' do
      ratings = [FactoryGirl.create(:rating, band_id: 1), FactoryGirl.create(:rating, band_id: 2), FactoryGirl.create(:rating, band_id: 3)]
      user.stub(ratings: ratings)
      recommender.rated_band_ids.should =~ [1, 2, 3]
    end
  end

end