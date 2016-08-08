class MoviesController < ApplicationController
	before_action :find_movie, only: [:show, :destroy]

	def index
		@movies = current_user.movies
	end

	def search
	end

	def create
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