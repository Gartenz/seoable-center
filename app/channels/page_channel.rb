class PageChannel < ApplicationCable::Channel
  def follow(params)
    stream_from "page_#{params['id']}"
  end
end
