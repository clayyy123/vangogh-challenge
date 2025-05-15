require_relative '../main.rb'

artists = [
  {
    name: 'Vincent Van Gogh',
    file: 'van-gogh-paintings'
  },
  {
    name: 'Pablo Picasso',
    file: 'pablo-picasso-paintings'
  },
  {
    name: 'Salvador Dali',
    file: 'salvador-dali-paintings'
  }
]

artists.each do |artist|
  describe "Knowledge graph for #{artist[:name]} Paintings from Google" do
  
    before(:all) do
      @data_array = parse_search_result("./files/#{artist[:file]}.html")
    end

    it 'returns a non empty array' do
      expect(@data_array).not_to be_empty
    end

    it 'returns an array of objects with expected keys' do
      expect(@data_array).to all(include(:name, :extensions, :link, :image))
    end

    it 'makes sure :name is a string and non empty' do
      @data_array.each do |data|
        expect(data[:name]).to be_a(String)
        expect(data[:name]).not_to be_empty
      end
    end

    it 'makes sure :link is a string and non empty' do
      @data_array.each do |data|
        expect(data[:link]).to be_a(String)
        expect(data[:link]).not_to be_empty
      end
    end

    it 'makes sure :image is a string and non empty' do
      @data_array.each do |data|
        expect(data[:image]).to be_a(String)
        expect(data[:image]).not_to be_empty
      end
    end

    it 'makes sure :extensions is an array and non empty' do
      @data_array.each do |data|
        expect(data[:extensions]).to be_a(Array)
        expect(data[:extensions]).not_to be_empty
      end
    end
  end
end


