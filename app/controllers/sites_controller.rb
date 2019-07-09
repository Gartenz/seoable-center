class SitesController < ApplicationController
  before_action :set_sites, only: %i[index create]

  def index
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to site_path(@site)
    else
      render :index
    end
  end

  def show
    @site = Site.find(params['id'])
    @pages = @site.pages.page(params[:page])
  end

  def destroy
    site = Site.find(params['id'])
    DestroySiteJob.perform_later(site)
  end

  def update_info
    site = Site.find(params['site_id'])
    UpdateSiteJob.perform_later(site)
  end

  private
  def set_sites
    @sites = Site.all
  end

  def site_params
    params.require(:site).permit(:url)
  end
end
