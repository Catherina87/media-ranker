class TopWorksController < ApplicationController

  def index 
    @albums = Work.top_albums
    @books = Work.top_books
  end
end
