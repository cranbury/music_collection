class Artist
  attr_accessor :name
  attr_reader :albums

  def initialize(params)
    @name = params[:name]
    @albums = []
  end

  def add_album(album)
    @albums << albums
  end
end
