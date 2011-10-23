class VideosController < ApplicationController

  def index
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
  end

  def new
    @video = Video.new("", params[:token])
  end

  def create
    @video = Video.new(params[:title], params[:token])
    if @video.valid?
      @response = Youtube.postVideoMetadata(@video)
      @url = @response.url + "?nexturl=" + request.url + "/videos"
      render "upload"
    else
      render "new"
    end
  end

end