require_relative 'html_generator'

if ARGV.empty?
  puts "Choose an option. usage: ruby router.rb [action]"

else
  action = ARGV[0]
  generator = HtmlGenerator.new

  if 
    action == "index"
    
    if ARGV[1]= nil
      generator.index(search_text)

  else
    search_item = ARGV[1]
    generator.index(search_item)
  end

  elsif 
    action == "show"
    inventory_id = ARGV[1]

  if 
    inventory_id.nil?
    puts "ID not known- please check and try again: ruby router.rb show [inventory_id]"
  end
    
  generator.show(id)

end