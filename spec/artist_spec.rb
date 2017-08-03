require_relative '../artist'

RSpec.describe Artist do
  before(:each) do
    @artist = Artist.new(name: 'The Pillows')
  end

  context "when creating a new artist" do
    it "takes on the name passed" do
      expect(@artist.name).to eq 'The Pillows'
    end
  end
end
