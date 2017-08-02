class Album
  attr_accessor :title, :artist

  def initialize(params)
    @played = false
    @title = params[:title]
    @artist = params[:artist]
  end

  def play
    @played = true
  end
end
