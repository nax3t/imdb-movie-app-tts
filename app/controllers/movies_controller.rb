class MoviesController < ApplicationController
	before_action :find_movie, only: [:show, :destroy]

	def index
		@movies = current_user.movies
	end

	def search
		@movie = Movie.new
		# create end point from search query and API url
		q = params[:q]
		url = "http://www.omdbapi.com/?s="
		end_point = url + q
		# make API call to end point, set result equal to response
		response = RestClient.get(end_point)
		# parse response.body and set result equal to data
		data = JSON.parse(response.body)
		@movies = data["Search"]
	end

	def details
		imdb_id = params[:imdb_id]
		url = "http://www.omdbapi.com/?i="
		end_point = url + imdb_id + '&plot=full'

		response = RestClient.get(end_point)
		@movie = JSON.parse(response.body)
	end

	def create
		@movie = current_user.movies.build(movie_params)
		if @movie.save
			redirect_to [current_user, @movie]
		else
			flash[:alert] = "Sorry, your movie couldn't be favorited, please try again."
			redirect_to welcome_path
		end
	end

	def show
	end

	def destroy
		@movie.destroy
		redirect_to root_path
	end

	private
		def find_movie
			@movie = Movie.find(params[:id])
		end

		def movie_params
			params.require(:movie).permit(:title, :year)
		end
end