class WorksController < ApplicationController

  def index 
    @work = Work.all
  end

end
