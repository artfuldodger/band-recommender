class SimilarityCalculators::EuclideanDistance

  def initialize(user)
    @user = user
  end

  # You need a function that gives higher values for people who are similar.
  # This can be done by adding 1 to the function (so you don't get a division-by-zero error) and inverting it.
  # - Segaran, Toby (2008-12-17). Programming Collective Intelligence: Building Smart Web 2.0 Applications (Kindle Locations 918-919). OReilly Media - A. Kindle Edition. 
  def similarity(other_user)
    return 0 if common_bands(other_user).empty?

    1 / (1 + cumulative_euclidean_distance(other_user))
  end

  # Euclidean distance score, which takes the items that people have ranked in common and 
  # uses them as axes for a chart. You can then plot the people on the chart and see how
  # close together they are,
  # - Segaran, Toby (2008-12-17). Programming Collective Intelligence: Building Smart Web 2.0 Applications (Kindle Locations 903-905). OReilly Media - A. Kindle Edition. 
  def cumulative_euclidean_distance(other_user)
    sum = common_bands(other_user).map { |band| square_of_rating_difference(other_user, band) }.sum
    Math.sqrt(sum)
  end

  def square_of_rating_difference(other_user, band)
    our_user_rating = band.ratings.where(user_id: @user.id).first.score
    other_user_rating = band.ratings.where(user_id: other_user.id).first.score
    (our_user_rating - other_user_rating)**2
  end

  # Bands both users have rated
  def common_bands(other_user)
    @user.bands & other_user.bands
  end

end