class Session
  attr_reader :user_quit
  def initialize
    @artists = {}
    @albums = {}
    @quit = false
    welcome
    input_loop
  end

  def welcome
    puts 'Welcome to your music collection!'
  end

  def input_loop
    until user_quit
      prompt
    end
    quit
  end

  def prompt
    command = gets.chomp
    command_words = command.split

    if command_words.first =='add'
      add command
    elsif command_words.first == 'play'
      play command_words.second
    elsif command_words.first == 'show'
      show command_words
    end
  end

  def add(command)
    string_parts = command.split(' "')
    name = string_parts[2][0...-1]
    title = string_parts[1][0...-1]

    artist = add_artist(name)
    add_album(title, artist)
  end

  def add_artist(name)
    @artists[name] || @artists[name] = Artist.new(name: name)
  end

  def add_album(title, artist)
    @albums[title] || @albums[title] = Album.new(title: title, artist: artist)
  end

  def play(title)
    if @albums[title]
      @album[title].play
      puts "You're listening to #{title}"
    else
      puts "There's no album in the collection with title: #{title}"
    end
  end

  def show(command_words)
    if command_words.a
  end

  def quit
    puts 'Bye!'
  end

end
