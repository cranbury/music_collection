require_relative '../album'
require_relative '../artist'

RSpec.describe Album do
  before(:each) do
    @artist = Artist.new(name: 'The Pillows')
    @album = Album.new(title: 'FLCL', artist: @artist)
  end

  context "when creating a new album" do
    it "takes on the name passed" do
      expect(@artist.name).to eq 'The Pillows'
    end
    it "belongs to the correct artist" do
      expect(@album.artist.name).to eq @artist.name
      expect(@album.by_artist?(@artist.name)).to eq(true)
    end
  end

  context "when playing an album" do
    it "should be unplayed after create" do
      expect(@album.played?).to eq(false)
      expect(@album.unplayed?).to eq(true)
    end

    it "should change state to played" do
      @album.play
      expect(@album.played?).to eq(true)
      expect(@album.unplayed?).to eq(false)
    end
  end

  context "to_s" do
    it "should return a string with no params" do
      expect(@album.to_s.class).to eq String
    end

    it "should return a string with history param passed" do
      expect(@album.to_s(history: true).class).to eq String
    end

    it "should not include play status without history" do
      expect(@album.to_s).not_to include 'played'
    end

    it "should not include play status without history" do
      expect(@album.to_s(history: true)).to include 'played'
    end
  end
end
