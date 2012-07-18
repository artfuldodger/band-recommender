require 'spec_helper'

describe Recommender do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommender.new(user) }

  describe '#common_bands' do
    it 'returns the bands both users have rated' do
      common_bands = [FactoryGirl.create(:band), FactoryGirl.create(:band)]
      this_user_bands  = [FactoryGirl.create(:band)] + common_bands
      other_user_bands = [FactoryGirl.create(:band)] + common_bands + [FactoryGirl.create(:band)]

      user.stub(bands: this_user_bands)
      other_user.stub(bands: other_user_bands)

      recommender.common_bands(other_user).should =~ common_bands
    end
  end

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

  describe '#similarity' do
    it 'returns 0 if users have not rated any of the same bands' do
      recommender.stub(shared_rated_bands: [])
      recommender.similarity(other_user).should == 0
    end

    it 'returns 1 / (1 + cumulative_euclidean_distance)' do
      recommender.stub(cumulative_euclidean_distance: 5)
      recommender.similarity(other_user).should == 1/6
    end
  end

  describe '#square_of_rating_difference' do
    it "returns the difference between the users' ratings for the specified band, squared" do
      band = FactoryGirl.create(:band)
      our_rating   = FactoryGirl.create(:rating, band: band, user: user, score: 5)
      other_rating = FactoryGirl.create(:rating, band: band, user: other_user, score: 2)
      recommender.square_of_rating_difference(other_user, band).should == 9
    end
  end

  describe '#cumulative_euclidean_distance' do
    it 'sums the square_of_rating_difference for each band both have rated and takes the square root' do
      recommender.stub(common_bands: [1,2,3,4])
      recommender.stub(square_of_rating_difference: 16) # difference of 4 for 4 ratings
      recommender.cumulative_euclidean_distance(other_user).should == 8 # sqrt(64) = 8
    end
  end
end