class HomeController < ApplicationController

  def index
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
  end

  def endorsements
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
  end
end