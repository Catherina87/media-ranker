class VotesController < ApplicationController


  def create 
    
    if session[:user_id] == nil 
      flash[:error] = "Please log in to upvote"
      return
    end

    maybe_vote = Vote.find_by(
      work_id: params[:work_id], 
      user_id: session[:user_id]
    )

    if maybe_vote == nil
      @vote = Vote.create(
        work_id: params[:work_id],
        user_id: session[:user_id],
        date: "TODAY"
      )
    else 
      flash[:error] = "Already voted"
      return
    end

    redirect_to work_path(params[:work_id])
  end
end
