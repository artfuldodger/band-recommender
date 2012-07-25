require 'spec_helper'

describe SimilarityCalculators::EuclideanDistance do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:calculator) { SimilarityCalculators::EuclideanDistance.new(user) }

  describe '#common_bands' do
    it 'returns the bands both users have rated' do
      common_bands = [FactoryGirl.create(:band), FactoryGirl.create(:band)]
      this_user_bands  = [FactoryGirl.create(:band)] + common_bands
      other_user_bands = [FactoryGirl.create(:band)] + common_bands + [FactoryGirl.create(:band)]

      user.stub(bands: this_user_bands)
      other_user.stub(bands: other_user_bands)

      calculator.common_bands(other_user).should =~ common_bands
    end
  end

  describe '#similarity' do
    it 'returns 0 if users have not rated any of the same bands' do
      calculator.stub(shared_rated_bands: [])
      calculator.similarity(other_user).should == 0
    end

    it 'returns 1 / (1 + cumulative_euclidean_distance)' do
      calculator.stub(cumulative_euclidean_distance: 5)
      calculator.similarity(other_user).should == 1/6
    end
  end

  describe '#square_of_rating_difference' do
    it "returns the difference between the users' ratings for the specified band, squared" do
      band = FactoryGirl.create(:band)
      our_rating   = FactoryGirl.create(:rating, band: band, user: user, score: 5)
      other_rating = FactoryGirl.create(:rating, band: band, user: other_user, score: 2)
      calculator.square_of_rating_difference(other_user, band).should == 9
    end
  end

  describe '#cumulative_euclidean_distance' do
    it 'sums the square_of_rating_difference for each band both have rated and takes the square root' do
      calculator.stub(common_bands: [1,2,3,4])
      calculator.stub(square_of_rating_difference: 16) # difference of 4 for 4 ratings
      calculator.cumulative_euclidean_distance(other_user).should == 8 # sqrt(64) = 8
    end
  end
end