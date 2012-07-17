# Inspiration: Segaran, Toby (2008-12-17). Programming Collective Intelligence: Building Smart Web 2.0 Applications
class Recommender

  def initialize(user)
    @user = user
  end

  def recommendations
    totals = Hash.new(0)
    similarity_sums = Hash.new(0)
    all_other_users.each do |other_user|
      sim = similarity(other_user)
      next if sim <= 0
      other_user.ratings.where('band_id not in (?)', rated_band_ids).each do |other_user_rating|
        totals[other_user_rating.band] += other_user_rating.score * sim
        similarity_sums[other_user_rating.band] += sim
      end
    end
    # Return the normalized list
    rankings = {}
    totals.each { |band, total| rankings[band] = (total / similarity_sums[band]) }
    rankings.sort_by { |band, score| -score }[0..20]
  end

  private
  # Euclidean Distance Score - essentially graphs them
  def similarity(other_user)
    shared_rated_bands = common_bands(other_user)
    return 0 if shared_rated_bands.empty?

    sum_of_squares = 0
    shared_rated_bands.each do |band|
      our_user_rating = band.ratings.where(user_id: @user.id).first.score
      other_user_rating = band.ratings.where(user_id: other_user.id).first.score
      sum_of_squares += (our_user_rating - other_user_rating)**2
    end
    1 / (1+Math.sqrt(sum_of_squares))
  end

  # Bands both users have rated
  def common_bands(other_user)
    @user.bands & other_user.bands
  end

  def all_other_users
    User.where('id != ?', @user.id)
  end

  def rated_band_ids
    @user.ratings.map(&:band_id)
  end

end
