class PanelsController < ApplicationController

  def index
  	@panel = Panel.first
  end

  def show
  	@panel = Panel.first
  end

  def new
  	@panel = Panel.first
  end

  def edit
  	@panel = Panel.find(params[:id])
  end

  def update
    @panel = Panel.find(params[:id])
    if @panel.update_attributes(panel_params)
      flash[:success] = "Panel actualizado"
      redirect_to panel_path(@panel)
    else
      render 'edit'
    end
  end

  private

  def panel_params
	  params.require(:panel).permit( :name, :timezone, :quota_per_group, :error_range, :logo )
  end

end