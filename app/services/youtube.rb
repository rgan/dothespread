require 'net/http'
require 'uri'

class Youtube
  GDATA_KEY = ""

  def self.postVideoMetadata(video)
    post_data = <<-xml
<?xml version="1.0"?>
<entry xmlns="http://www.w3.org/2005/Atom"
  xmlns:media="http://search.yahoo.com/mrss/"
  xmlns:yt="http://gdata.youtube.com/schemas/2007">
  <media:group>
    <media:title type="plain">#{video.title}</media:title>
    <media:category
      scheme="http://gdata.youtube.com/schemas/2007/categories.cat">People
    </media:category>
    <media:keywords>dothespread</media:keywords>
  </media:group>
</entry>
    xml
    url = URI.parse('http://gdata.youtube.com/action/GetUploadToken')
    request = Net::HTTP::Post.new(url.path, { 'Authorization' => "AuthSub token=#{video.token}",
                                'GData-Version' => '2',
                                'X-GData-Key' => GDATA_KEY,
                                'Content-Type' => 'application/atom+xml; charset=UTF-8',
                              })
    request.body = post_data
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    raise response.body unless response.code == "200"
    return YoutubeResponse.from(response.body)
  end
end