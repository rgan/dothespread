class VideosController < ApplicationController
  def index
  end

  def new
      @token = params[:token]
      @video = Video.new
  end

end