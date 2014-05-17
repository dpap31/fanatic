class TeamsController < ApplicationController


  def index
  	 @teams = Team.all
	 render json: Team.all
  end

  def new
  	 @team = Team.new
  end

  def team_params
    params[:team].permit(team_ids: [])
  end
 end