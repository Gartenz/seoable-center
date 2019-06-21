class SitesController < ApplicationController
  before_action :set_sites, only: %i[index create]

  def index
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @site = Site.find(params['id'])
  end

  private
  def set_sites
    @sites = Site.all
  end

  def site_params
    params.require(:site).permit(:url)
  end
end
