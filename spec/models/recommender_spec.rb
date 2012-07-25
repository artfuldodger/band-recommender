require 'spec_helper'

describe Recommender do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommender.new(user) }

  describe '#rated_band_ids' do
    it 'returns all ids of the bands rated by the user' do
      ratings = [FactoryGirl.create(:rating, band_id: 1), FactoryGirl.create(:rating, band_id: 2), FactoryGirl.create(:rating, band_id: 3)]
      user.stub(ratings: ratings)
      recommender.rated_band_ids.should =~ [1, 2, 3]
    end
  end

end