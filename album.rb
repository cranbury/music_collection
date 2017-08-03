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

  def played?
    @played
  end

  def unplayed?
    !@played
  end

  def by_artist?(artist_name)
    artist_name == @artist.name
  end

  def to_s(options = {})
    str = "\"#{title}\" by #{artist.name}" 
    str += " (#{@played ? 'played' : 'unplayed'})" if options[:history]
    str
  end
end
