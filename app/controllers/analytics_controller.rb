class AnalyticsController < ApplicationController

  def index
    @response = GoogleAnalytics.getFeed(params[:token])
  end
end