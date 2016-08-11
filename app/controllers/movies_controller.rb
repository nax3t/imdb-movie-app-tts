class MoviesController < ApplicationController
	before_action :find_movie, only: [:show, :destroy]

	def index
		@image_url = 'post-bg'
		user = User.find(params[:user_id])
		if current_user == user
			@movies = current_user.movies
		else
			flash[:alert] = "You do not have permission to access this page!"
			redirect_to root_path
		end
	end

	def search
		@image_url = 'about-bg'
		q = params[:q]
		@title = q
		# create end point from search query and API url
		url = "http://www.omdbapi.com/?s="
		end_point = url + q
		# make API call to end point, set result equal to response
		response = RestClient.get(end_point)
		# parse response.body and set result equal to data
		data = JSON.parse(response.body)
		@movies = data["Search"]
		if @movies
			render :search
		else
			flash[:alert] = "Sorry, your search came back empty, please try again."
			redirect_to root_path
		end
	end

	def details
		@movie = Movie.new
		imdb_id = params[:imdb_id]
		url = "http://www.omdbapi.com/?i="
		end_point = url + imdb_id + '&plot=full'

		response = RestClient.get(end_point)
		@movie_info = JSON.parse(response.body)
	end

	def create
		@movies = Movie.all
		if @movies.map(&:imdb_id).include?(movie_params[:imdb_id])
			@movie = Movie.find_by(imdb_id: movie_params[:imdb_id])
			@movie.users << current_user
			flash[:notice] = "#{@movie.title} successfully favorited."
			redirect_to @movie
		else
			@movie = current_user.movies.build(movie_params)
			if current_user.save
				flash[:notice] = "#{@movie.title} successfully favorited."
				redirect_to @movie
			else
				flash[:alert] = "Unable to favorite movie."
				redirect_to root_path
			end
		end
	end

	def show
		@review = Review.new
	end

	def destroy
		current_user.movies.delete(@movie)
		flash[:alert] = "Movie successfully deleted!"
		redirect_to user_movies_path(current_user)
	end

	private
		def find_movie
			@movie = Movie.find(params[:id])
		end

		def movie_params
			params.require(:movie).permit(:title, :year, :plot, :imdb_id)
		end
end