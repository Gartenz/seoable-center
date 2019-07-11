class PagesController < ApplicationController
  def show
    @page = Page.find(params['id'])
    if @page.statistics.first
      @page_statistics = JSON.parse @page.statistics.first.body
    else
      @page_statistics = {}
    end
  end

  def statistics
    @page = Page.find(params['page_id'])
    @page_statistics = Services::Seo::Head.new(@page).check
    @page.statistics.create(body: @page_statistics.to_json)

    respond_to do |format|
      format.json { render json: @page_statistics }
    end
  end
end
