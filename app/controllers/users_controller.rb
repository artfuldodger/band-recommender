class UsersController < ApplicationController
  before_filter :get_user, only: [:show, :edit, :update]

  def index
    @users = User.order(:name).paginate(page: params[:page])
  end

  def show
    @ratings = @user.ratings.order('bands.name').paginate(page: params[:ratings_page])
    @band_recommendations = Recommenders::Band.new(@user).recommendations
    @user_recommendations = Recommenders::User.new(@user).recommendations
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user), notice: 'User created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), notice: 'User updated!'
    else
      render :edit
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end
end
