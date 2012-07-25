class Recommenders::User

  def initialize(user)
    @user = user
    @similarity_calculator = SimilarityCalculators::EuclideanDistance.new(user)
  end

  def recommendations
    other_users = @user.all_other_users
    other_users.each { |other_user| other_user.similarity = @similarity_calculator.similarity(other_user) }
    other_users.sort_by(&:similarity).reverse.first(20)
  end

end
