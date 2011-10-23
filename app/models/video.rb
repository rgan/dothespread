class Video
  include ActiveModel::Validations

  attr_reader :title, :token

  validates_presence_of :title

  def initialize(title, token)
    @title, @token = title, token
  end

  def persisted?
    false
  end

  def ==(another_video)
    self.title == another_video.title
    self.token == another_video.token
  end
end