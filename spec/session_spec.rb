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
      
      # stdout.write('quit\n')
      stdout.rewind
      session = Session.new
      expect(session.albums.length).to eq(0)
      expect(session.artists.length).to eq(0)
    end
  end

  context'add a song' do
    it 'should add a song' do
      allow(stdout).to receive(:gets).and_return('add "Ride the Lightning" "Metallica"','quit')
      
      # stdout.write('quit\n')
      stdout.rewind
      session = Session.new(stdout)
      expect(session.albums.length).to eq(1)
      expect(session.artists.length).to eq(1)
    end
  end
end