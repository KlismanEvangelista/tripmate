class ReviewsController < ApplicationController
  before_action :set_travel, only: %i[create new]
  before_action :set_user, only: %i[index show]
  before_action :set_review, only: %i[show edit update destroy]

  def show
  end

  def index
    # reviews of a user to improve
    if params[:user_id].present?
      @reviews = @user.reviews
    else
      # reviews made by the current user
      @reviews = Review.where(user_id: current_user)
    end
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.travel = @travel
    if @review.save!
      flash[:notice] = ''
      redirect_to review_path(@review)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    flash[:notice] = ''
    @review.update(review_params)
    redirect_to reviews_path
  end

  def destroy
    if @review
      flash[:notice] = ''
      @review.destroy
      redirect_to reviews_path, status: :see_other
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
