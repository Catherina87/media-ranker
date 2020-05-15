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

  def self.top_albums
    albums = self.sort_album_works
    return albums.sample(5)
  end

  def self.top_books
    books = self.sort_book_works
    return books.sample(5)
  end

end
