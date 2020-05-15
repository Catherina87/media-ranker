class TopWorksController < ApplicationController

  def index 
    @albums = Work.top_albums
    @books = Work.top_books
    @movies = Work.top_movies
    @spotlight = Work.get_spotlight
  end
end
