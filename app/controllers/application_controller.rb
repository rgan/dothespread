class ApplicationController < ActionController::Base
  protect_from_forgery
  CACHE_CONTROL_VALUE='public, max-age=300'
  before_filter :set_iphone_format

  def set_iphone_format
    if is_iphone_request?
      request.format = :iphone
    end
  end

  def is_iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/   # works for both iphone & ipad
  end

end
