class ApplicationController < ActionController::Base
  protect_from_forgery
  CACHE_CONTROL_VALUE='public, max-age=300'
end
