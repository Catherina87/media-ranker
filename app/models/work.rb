class Work < ApplicationRecord
  has_many :votes
  has_many :users, :through => :votes

  validates :category, presence: true 
  validates :title, presence: true 
  validates :title, uniqueness: { case_sensitive: false} 
  validates :creator, presence: true 
  validates :publication_year, presence: true 
  validates :publication_year, numericality: { only_integer: true }
  validates :description, presence: true 

  def self.sort_album_works
    albums = Work.where(category: "album").order(title: :asc)
    
  end

  def self.sort_book_works
    return Work.where(category: "book")
  end

  def self.sort_movie_works
    return Work.where(category: "movie")
  end

  def self.top_albums
    albums = self.sort_album_works
    return albums.sample(5)
  end

  def self.top_books
    books = self.sort_book_works
    return books.sample(5)
  end

  def self.top_movies
    movies = self.sort_movie_works
    return movies.sample(5)
  end

  def self.get_spotlight
    return Work.first
  end

end
