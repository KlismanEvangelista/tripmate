class ReviewsController < ApplicationController
  before_action :set_travel, only: %i[create new]
  before_action :set_user, only: %i[index show]
  before_action :set_review, only: %i[show edit update destroy]

  def show
    @current_user = current_user
  end

  def index
    # reviews of a user
    if @user.present?
      @reviews = @user.plans.map(&:travels).flatten.map(&:reviews).flatten
      @reviews = @reviews.sort_by(&:created_at).reverse

      total_reviews = @reviews.size
      total_rating = @reviews.sum(&:rating)
      @rating = total_reviews > 0 ? (total_rating.to_f / total_reviews).round(2) : 0

      @plans = @user.plans.limit(3)
    else
      @reviews = Review.none
    end
  end

  def my_reviews
    # reviews made by current user
    @reviews = Review.where(user_id: current_user)
    @user = current_user
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.travel_id = @travel.id
    if @review.save!
      flash[:notice] = ''
      redirect_to user_review_path(@review.user_id, @review.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    flash[:notice] = ''
    @review.update(review_params)
    flash[:notice] = "Reseña actualizada exitosamente."
    redirect_to my_reviews_path
  end

  def destroy
    if @review
      flash[:notice] = ''
      @review.destroy
      flash[:notice] = "Reseña eliminada exitosamente."
      redirect_to my_reviews_path, status: :see_other
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :comment, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_travel
    @travel = Travel.find(params[:travel_id])
  end
end
