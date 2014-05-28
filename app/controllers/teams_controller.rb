class TeamsController < ApplicationController

  def index
    @teams = Team.all
    render json: Team.all
  end

  def new
    @team = Team.new
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to @team, notice: "Successfully created product."
    else
      render :edit
    end
  end

  def team_params
    params[:team].permit(team_ids: [])
  end
end