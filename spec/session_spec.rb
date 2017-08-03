require 'pry'
require_relative '../album'
require_relative '../artist'
require_relative '../session'

RSpec.describe Session do
  let(:stdout) { StringIO.new }
  # let(:session) { Session.new(stdout) }
  context 'new session' do
    it 'should start with an empty catalog' do
      allow(stdout).to receive(:gets) { 'quit' }

      session = Session.new(stdout)
      expect(session.albums.length).to eq(0)
      expect(session.artists.length).to eq(0)
    end
  end

  context 'add a song' do
    it 'should add a song' do
      allow(stdout).to receive(:gets).and_return('add "Ride the Lightning" "Metallica"','quit')
      
      session = Session.new(stdout)
      expect(session.albums.length).to eq(1)
      expect(session.artists.length).to eq(1)
    end
  end

  context 'playing albums changes state' do
    it 'should store an unplayed song as unplayed' do
      allow(stdout).to receive(:gets).and_return('add "Ride the Lightning" "Metallica"','quit')
      
      session = Session.new(stdout)
      expect(session.albums.values.first.unplayed?).to eq(true)
    end
    
    it 'should store an unplayed song as unplayed' do
      allow(stdout).to receive(:gets)
        .and_return('add "Ride the Lightning" "Metallica"','play "Ride the Lightning"', 'quit')
      
      session = Session.new(stdout)
      album = session.albums.values.first
      expect(album.unplayed?).to eq(false)
    end
  end

  context 'albums and artists are unique' do
    it 'should store two albums when two are entered' do
      allow(stdout).to receive(:gets)
        .and_return('add "Ride the Lightning" "Metallica"','play "Ride the Lightning"',
                    'add "Licensed to Ill" "Beastie Boys"', 'quit')
      
      session = Session.new(stdout)
      expect(session.albums.length).to eq(2)
      expect(session.artists.length).to eq(2)
    end

    it 'should only store one artist for two albums with the same artist' do
      allow(stdout).to receive(:gets)
        .and_return('add "Pauls Boutique" "Beastie Boys"','play "Ride the Lightning"',
                    'add "Licensed to Ill" "Beastie Boys"', 'quit')
      
      session = Session.new(stdout)
      expect(session.artists.length).to eq(1)
    end

    it 'should only store one record when a song is added twice' do
      allow(stdout).to receive(:gets)
        .and_return('add "Licensed to Ill" "Beastie Boys"','play "Ride the Lightning"',
                    'add "Licensed to Ill" "Beastie Boys"', 'quit')
      
      session = Session.new(stdout)
      expect(session.albums.length).to eq(1)
      expect(session.artists.length).to eq(1)
    end
  end
end