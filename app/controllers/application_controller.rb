class ApplicationController < ActionController::Base
  protect_from_forgery
  CACHE_CONTROL_VALUE='public, max-age=3600'
  before_filter :set_mobile_format

  def set_mobile_format
    if is_mobile_request?
      request.format = :mobile
    end
  end

  def is_mobile_request?
    params[:mobile]
  end

end
