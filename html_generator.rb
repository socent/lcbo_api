require 'json'
require 'open-uri'

class HtmlGenerator
  def index(search=nil)
    inventory_array = []
    inventory = retrieve_data("http://lcboapi.com/products?q=#{search_text}")

    print_header

    puts "<div class='viewport'>"
    puts "<div class='container'>"
    puts "<img src='http://gelcommunications.com/wp-content/uploads/2011/02/lcbo.png' class='logo'>"
    puts "<h1>All products</h1>"

    # Loop over the products, printing each one
    inventory.each do |product|
      puts "<div class='product'>"
      puts "  <h2>#{product['name']}</h2>"
      puts "  <img src='#{product['image_thumb_url']}'  class='product-thumbnail'/>"
      puts "  <ul class='product-data'>"
      puts "    <li>id: #{product['id']}</li>"
      puts "    <li>origin: #{product['origin']}</li>"
      puts "    <li>Producer: #{product['producer_name']}</li>"
      puts "    <li>Primary Category: #{product['primary_category']}</li>"
      puts "    <li>Secondary Category: #{product['secondary_category']}</li>"
      puts "    <li>Style: #{product['style']}</li>"
      puts "    <li><strong>Alcohol Content: $#{alcohol_content(product['alcohol_content'])}</strong></li>"
      puts "    <li>Volume: #{product['volume_in_milliliters']} ml</li>"
      puts "    <li>Price: $#{format_price(product['price_in_cents'])}</li>"
      puts "  </ul>"
      puts "</div>"
    end
    
    puts "<footer>"
    puts "<footer>Type in product ID for more detailed info</footer>"
    puts "</footer>"
    print_footer
  end

  def show(product_id)
    product = retrieve_data("http://lcboapi.com/products/#{product_id}")

    puts "<div class='product'>"
    puts "  <h2>#{product['name']}</h2>"
    puts "  <img src='#{product['image_url']}'  class='product-image'/>"
    puts "  <ul class='product-data'>"
    puts "    <li>id: #{product['id']}</li>"
    puts "    <li>Origin: #{product['origin']}</li>"
    puts "    <li>Producer Name: #{product['producer_name']}</li>"
    puts "    <li>Primary Category: #{product['primary_category']}</li>"
    puts "    <li>Secondary Category: #{product['secondary_category']}</li>"
    puts "    <li>Style: #{product['style']}</li>"
    puts "    <li>Volume: #{product['volume_in_milliliters']} ml</li>"
    puts "    <li>Alcohol Content: $#{alcohol_content(product['alcohol_content'])}</li>"
    puts "    <li>Package: #{product['package']}</li>"
    puts "    <li>Price: $#{format_price(product['price_in_cents'])}</li>"
    puts "    <li>Serving Suggestion: #{product['serving_suggestion']}</li>"
    puts "    <li>Tasting Note: #{product['tasting_note']}</li>"
    puts "    <li>Tags: #{product['tags']}</li>"
    puts "  </ul>"
    puts "</div>"

    print_header
  end

  def print_header
    puts "<html>"
    puts "  <head>"
    puts "    <title>All Products</title>"
    puts "    <link rel='stylesheet' href='normalize.css' type='text/css'>"
    puts "    <link rel='stylesheet' href='styles.css' type='text/css'>"
    puts "  </head>"
    puts "  <body>"
  end

  def print_footer
    puts "  </div>"
    puts "  </div>"
    puts "  </body>"
    puts "</html>"
  end

  def retrieve_data(url)
    raw_response = open(url).read

    parsed_response = JSON.parse(raw_response)

    result = parsed_response["result"]
  end

  def format_price(cents_string)
    cents_string.to_f/100
  end

end