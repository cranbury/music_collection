class Session
  attr_reader :albums, :artists
  def initialize(stdout=nil)
    @artists = {}
    @albums = {}
    @quit = false
    @stdout = stdout
    welcome
    input_loop
    
  end

  def welcome
    puts
    puts 'Welcome to your music collection!'
  end

  def input_loop
    until @quit
      puts
      print '>'
      prompt
    end
  end

  def prompt
    command = @stdout ? @stdout.gets.chomp : gets.chomp
    command_words = command.split

    puts
    
    if command_words.first =='add'
      add command
    elsif command_words.first == 'play'
      play quoted_str(command)
    elsif command_words.first == 'show'
      show command_words
    elsif command_words.first == 'quit'
      quit
    end
  end

  def add(command)
    name = quoted_str(command)
    title = quoted_str(command, -2)

    artist = add_artist(name)
    add_album(title, artist)
  end

  def add_artist(name)
    @artists[name] || @artists[name] = Artist.new(name: name)
  end

  def add_album(title, artist)
    if @albums[title]
      puts "You already added \"#{title}\" by #{artist.name}"
    else
      @albums[title] = Album.new(title: title, artist: artist)
      puts "Added \"#{title}\" by #{artist.name}"
    end
  end

  def play(title)
    if @albums[title]
      @albums[title].play
      puts "You're listening to \"#{title}\""
    else
      puts "There's no album in the collection with title: \"#{title}\""
    end
  end

  def show(command_words)
    albums = @albums.values
    show_play_status = false
    artist = nil

    if command_words[1] == 'all'
      show_play_status = true
    elsif command_words[1] == 'unplayed'
      albums = albums.select(&:unplayed?)
    elsif command_words[1] == 'played'
      albums = albums.select(&:played?)
    end

    if command_words[2] == 'by'
      artist = quoted_str(command_words.join(' '))
      albums = albums.select{ |al| al.by_artist?(artist) }
    end
    
    albums.each { |al| puts al.to_s(history: show_play_status) }
  end

  def quoted_str(commands, position = -1)
    commands.split(' "')[position][0...-1]
  end

  def quit
    @quit = true
    puts 'Bye!'
  end

end
