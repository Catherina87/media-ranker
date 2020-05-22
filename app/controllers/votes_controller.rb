class VotesController < ApplicationController

  before_action :require_login, only: [:create]

  def create 
    work = Work.find_by(id: params[:work_id])

    if work.nil?
      head :not_found 
      return
    end

    maybe_vote = Vote.find_by(
      work_id: params[:work_id], 
      user_id: session[:user_id]
    )

    if maybe_vote == nil
      time = Time.now
      @vote = Vote.create(
        work_id: params[:work_id],
        user_id: session[:user_id],
        date: time.strftime('%b %d, %Y')
      )
    else 
      flash[:already_voted] = "You already voted for this work"
      redirect_back(fallback_location: root_path)
      return
    end

    flash[:upvote_success] = "Successfully upvoted!"
    redirect_back(fallback_location: root_path)
  end
end
