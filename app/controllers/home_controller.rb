class HomeController < ApplicationController

  def index
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
    respond_to do |format|
      format.html # index.html.erb
      format.mobile # index.mobile.erb
    end
  end

  def endorsements
    response.headers['Cache-Control'] = CACHE_CONTROL_VALUE
  end
end