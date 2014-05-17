class TeamsController < ApplicationController


  def index
	 render json: Team.all
  end

  def team_params

    params[:team].permit(:team_ids,{:cuisine_ids => []}),
  end
 end