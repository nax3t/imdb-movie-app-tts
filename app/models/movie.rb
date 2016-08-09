class Movie < ApplicationRecord
	validates :imdb_id, uniqueness: true
	has_and_belongs_to_many :users
	has_many :reviews, dependent: :destroy
end
