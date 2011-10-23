class YoutubeResponse
  attr_accessor :url, :token

  def self.from(response)
    url_match = /<url>(.*)<\/url>/.match(response)
    token_match = /<token>(.*)<\/token>/.match(response)
    raise response unless url_match && token_match
    YoutubeResponse.new(url_match[1], token_match[1])
  end

  def initialize(url, token)
    @url = url
    @token = token
  end
end