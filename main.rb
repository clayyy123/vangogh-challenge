require 'nokogiri'
require 'open-uri'
require 'pp'
# we want to dive into each element and find its children to match a pattern (make sure we are extracting data from the image section)
# needs to have an anchor, img, and div with two div children

# returns a boolean to see if parent matches a certain structure
def matches_structure(parent)
  children = parent.element_children

  # exactly two direct children: img and div
  if children.size == 2
    element_types = children.map do |child|
      child.name
    end

    if element_types == ['img', 'div']
      return true
    end
  end

  # one child which is a wp-grid-title element
  if children.size == 1 && children.first.name == 'wp-grid-tile'
    return true
  end

  # return false if first two conditions arent ment
  return false
end

# returns an array of objects with image data
def find_image_data(html_path)
  # parse html document
  html_doc =  Nokogiri::HTML(URI.open(html_path))
  parsed_array = []

  # grab all the anchors
  html_doc.css('a').each do |parent|
    # must contain a structure below the anchor
    next unless matches_structure(parent)

    # look for divs with exactly two div children
    image_info = nil
    parent.css('div').each do |div|
      if div.element_children.size == 2
        # assume both children are div until proven false
        are_both_divs = true
        div.element_children.each do |element_child|
          # if a child is not a div, change variable to false
          if element_child.name != 'div'
            are_both_divs = false
          end
        end

        # set div into variable
        if are_both_divs == true
          image_info = div
        end
      end
    end

    # strip the data from the parent and image_info
    if image_info
      date = image_info.element_children[1].text.strip
      parsed_array.push({
        name: image_info.element_children.first.text.strip,
        extensions: date.empty? ? [] : [date],
        link: "https://www.google.com#{parent['href']}",
        image: parent.at_css('img')['src']
      })
    end
  end

  # print the array out to see
  pp parsed_array
end




