require 'nokogiri'
require 'open-uri'

# function that parses html document and returns an array of image data
def parse_search_result(html_path)
  html_doc =  Nokogiri::HTML(URI.open(html_path))

  # maps through the image containers and grabs necessary data
  parsed_array = html_doc.css('div.iELo6').map do |element|
    # initialize object with data
    parsed_object = {
      name: element.at_css('div.pgNMRc').content,
      extensions: [
        element.at_css('div.cxzHyb').content
      ],
      link: "https://www.google.com#{element.at_css('a')['href']}",
      image: element.at_css('img.taFZJe')['src']
    }

  end
end

