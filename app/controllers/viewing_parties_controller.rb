class ViewingPartiesController < ApplicationController
  before_action :all_users, only: %i[new]

  def new
    @user = User.find(session[:user_id])
  end

  def create
    host_user = User.find(session[:id])
    party = ViewingParty.create!(
      duration: params[:duration],
      date: "#{params['date(1i)']}/#{params['date(2i)']}/#{params['date(3i)']}",
      start_time: "#{params['time(4i)']}:#{params['time(5i)']}",
      movie_title: params[:movie_title]
    )
    User.all.each do |user|
      if user.name == host_user.name
        PartyUser.create!(user_id: host_user.id, viewing_party_id: party.id, host: true)
      elsif params.keys.include?(user.name) && params[user.name.to_sym] == '1'
        PartyUser.create!(user_id: user.id, viewing_party_id: party.id)
      end
    end
    redirect_to dashboard_path
  end

  private

    def all_users
      @users = User.all.compact
      @users.keep_if { |user| user.id != params[:user_id] }
    end
end
