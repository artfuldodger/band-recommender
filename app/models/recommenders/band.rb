class Recommenders::Band

  def initialize(user)
    @user = user
    @similarity_calculator = SimilarityCalculators::EuclideanDistance.new(user)
  end

  def recommendations
    totals = Hash.new(0)
    similarity_sums = Hash.new(0)
    @user.all_other_users.each do |other_user|
      sim = @similarity_calculator.similarity(other_user)
      next if sim <= 0
      other_user.ratings.where('band_id not in (?)', rated_band_ids).each do |other_user_rating|
        totals[other_user_rating.band] += other_user_rating.score * sim
        similarity_sums[other_user_rating.band] += sim
      end
    end
    # Return the normalized list
    rankings = {}
    totals.each { |band, total| rankings[band] = (total / similarity_sums[band]) }
    rankings.sort_by { |band, score| -score }[0...20]
  end

  def rated_band_ids
    @user.ratings.map(&:band_id)
  end
end
