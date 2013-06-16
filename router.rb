require_relative 'html_generator'

if ARGV.empty?
  puts "Usage: ruby router.rb [action]"

else
  action = ARGV[0]
  generator = HtmlGenerator.new

  if 
    action == "index"
    search_text = ARGV[1]
    generator.index(search_text)

  elsif 
    action == "show"
    inventory_id = ARGV[1]

    if inventory_id.nil?
      puts "Usage: ruby router.rb show [inventory_id]"

    else
      generator.show(id)
    end

  else
    puts "Unknown action #{action}. Use index or show."
  end

end