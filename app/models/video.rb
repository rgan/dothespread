class Video
  include ActiveModel::Validations

  attr_reader :title, :token, :keywords

  validates_presence_of :title, :keywords

  def initialize(title, token, keywords)
    @title, @token, @keywords = title, token, keywords
  end

  def persisted?
    false
  end

  def ==(another_video)
    self.title == another_video.title
    self.token == another_video.token
    self.keywords == another_video.keywords
  end
end