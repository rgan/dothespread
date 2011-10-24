class VideosController < ApplicationController

  def index
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
  end

  def new
    @video = Video.new("", params[:token], t(:default_keywords))
  end

  def create
    form_params = params[:video_form]
    @video = Video.new(form_params[:title], form_params[:token], form_params[:keywords])
    if @video.valid?
      @response = Youtube.postVideoMetadata(@video)
      @url = @response.url + "?nexturl=" + request.url + "/uploaded"
      render "upload"
    else
      render "new"
    end
  end

  def uploaded
    @video_id = params[:id]
    @status = params[:status]
    render "uploaded"
  end

end