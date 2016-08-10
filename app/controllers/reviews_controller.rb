class ReviewsController < ApplicationController
  def create
  	@movie = Movie.find(params[:movie_id])
  	@review = @movie.reviews.build(review_params)
  	@review.user = current_user
  	if @movie.save
  		flash[:notice] = "Review added successfully."
  		redirect_to @movie
  	else
  		flash[:alert] = "Review could not be added, please try again."
  		redirect_to @movie
  	end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  	def review_params
  		params.require(:review).permit(:body)
  	end
end
