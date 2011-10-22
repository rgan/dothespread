class Video
  include ActiveModel::Validations

  attr_reader :title

  validates_presence_of :title

  def persisted?
    false
  end
end