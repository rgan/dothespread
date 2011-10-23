class VideosController < ApplicationController
  caches_page :index

  def index
  end

  def new
    @token = params[:token]
    @video = Video.new
  end

  def create

  end

end