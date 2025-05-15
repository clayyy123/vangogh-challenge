require_relative '../main.rb'

search_topics = [
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
  },
  {
    name: 'Whale Species',
    file: 'whale-species'
  },
  {
    name: 'White Lotus Cast',
    file: 'white-lotus-cast'
  },
]

search_topics.each do |topic|
  describe "Knowledge graph for #{topic[:name]}" do
  
    before(:all) do
      @data_array = find_image_data("./files/#{topic[:file]}.html")
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
      end
    end
  end
end


