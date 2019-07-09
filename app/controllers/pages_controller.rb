class PagesController < ApplicationController
  def show
    @page = Page.find(params['id'])
    GetPageStatisticsJob.perform_later(page)
  end
end
