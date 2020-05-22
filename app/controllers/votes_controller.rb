class VotesController < ApplicationController

  def create 
    
    if session[:user_id] == nil 
      flash[:log_in_to_upvote] = "Please log in to upvote"
      redirect_to works_path
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
      flash[:already_voted] = "Already voted for this work"
      redirect_back(fallback_location: root_path)
      return
    end

    flash[:upvote_success] = "Successfully upvoted!"
    redirect_back(fallback_location: root_path)
  end
end
