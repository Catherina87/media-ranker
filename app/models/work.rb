class Work < ApplicationRecord

  def self.sort_album_works
    return Work.where(category: "album")
  end

  def self.sort_book_works
    return Work.where(category: "book")
  end

  def self.sort_movie_works
    return Work.where(category: "movie")
  end

end
