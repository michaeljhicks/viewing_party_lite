class ViewingPartyController < ApplicationController
  before_action :find_user_and_movie, only: [:new, :create]

  def new
    user = User.find(session[:user_id]) if session[:user_id]
    if !user
      redirect_to movie_path(params[:movie_id])
      flash.notice = "You must be logged in or registered to create a viewing party"
    end
  end

  def create 
      @vp = ViewingParty.create!(movie_id: params[:movie_id], duration: params[:duration], date: params[:date], start_time: params[:start_time])
      @host = UserParty.create!(user_id: @user.id, viewing_party_id: @vp.id, host: true)
      params[:user].each do |invitee|
        UserParty.create!(user_id: invitee, viewing_party_id: @vp.id, host: false)
      end
      redirect_to dashboard_path
  end

  private

  def find_user_and_movie
    @user = User.find(session[:user_id]) if session[:user_id]
    @movie = MovieFacade.movie_id_search(params[:movie_id])
  end
end
