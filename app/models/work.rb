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
    puts "LOG: #{Vote.group(:work_id).count}"
    return Work.where(category: "album").left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')
  end

  def self.sort_book_works
    return Work.where(category: "book").left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')
  end

  def self.sort_movie_works
    return Work.where(category: "movie").left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')
  end

  def self.top_albums
    albums = self.sort_album_works
    return albums[0..9]
  end

  def self.top_books
    books = self.sort_book_works
    return books[0..9]
  end

  def self.top_movies
    movies = self.sort_movie_works
    return movies[0..9]
  end

  def self.get_spotlight
    # winners = []
    # winners << Work.top_albums.first.votes.count
    # winners << Work.top_books.first.votes.count
    # winners << Work.top_movies.first.votes.count
    # puts "WINNERS = #{winners}"

    # max_votes = winners.max

    # puts "MAX VOTES = #{winners[0].votes}"
    # Work.
    puts "TEST #{Work.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').first.title}"
    puts "TEST #{Work.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').first.votes.count}"
    return Work.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').first
  end

end
