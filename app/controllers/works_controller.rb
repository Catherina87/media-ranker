class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index 
    @work = Work.all
  end

  def show 
    if @work.nil?
      redirect_to works_path 
    end
  end

  def new 
    @work = Work.new
  end

  def create 
    @work = Work.new(work_params)
    if @work.save 
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      
      return
    else
      render :new
      return
    end

  end

  def edit 
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update 
    if @work.nil?
      head :not_found 
      return
    elsif @work.update(work_params)
      flash[:update_success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return 
    else
      render :edit 
      return
    end
  end

  def destroy
    if @work.nil? 
      redirect_to works_path
      return
    end

    @work.destroy
    redirect_to root_path
    flash[:delete_success] = "Successfully destroyed #{@work.category} #{@work.title}"
  end

  private 

  def work_params 
    return params.require(:work).permit(:category, :title, :creator,
    :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
