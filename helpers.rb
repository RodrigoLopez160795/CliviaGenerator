require "terminal-table"

module Helpers

    def print_welcome
        puts "#"*35
        puts "#   Welcome to Clivia Generator   #"
        puts "#"*35
    end

    def table_categories(title, headings, categories)
        table = Terminal::Table.new
        table.title = title
        table.headings = headings
        table.rows = categories.map do |row|
            [row["id"], row["name"]]
        end
        table
    end

    def ask_for_a_category
        id = ""
        loop do 
        puts "Please select a valid ID"
        print ">"
        id = gets.chomp.to_i
        break if id.between?(9,32)
        puts "Invalid ID"
        end
        id
    end

    def get_category_name(id, categories)
        categories.each do |category|
           return name = category["name"] if category["id"] == id
        end
    end
end

module CategoryHash
    CATEGORIES = [
        {"id" => 0, "name" => "Random category"},
        {"id" => 9, "name" => "General Knowledge"},
        {"id" => 10, "name" => "Entertainment: Books"},
        {"id" => 11, "name" => "Entertainment: Film"},
        {"id" => 12, "name" => "Entertainment: Music"},
        {"id" => 13, "name" => "Entertainment: Musicals & Theatres"},
        {"id" => 14, "name" => "Entertainment: Television"},
        {"id" => 15, "name" => "Entertainment: Video Games"},
        {"id" => 16, "name" => "Entertainment: Board Games"},
        {"id" => 17, "name" => "Science & Nature"},
        {"id" => 18, "name" => "Science: Computers"},
        {"id" => 19, "name" => "Science: Mathematics"},
        {"id" => 20, "name" => "Mythology"},
        {"id" => 21, "name" => "Sports"},
        {"id" => 22, "name" => "Geography"},
        {"id" => 23, "name" => "History"},
        {"id" => 24, "name" => "Politics"},
        {"id" => 25, "name" => "Art"},
        {"id" => 26, "name" => "Celebrities"},
        {"id" => 27, "name" => "Animals"},
        {"id" => 28, "name" => "Vehicles"},
        {"id" => 29, "name" => "Entertainment: Comics"},
        {"id" => 30, "name" => "Science: Gadgets"},
        {"id" => 31, "name" => "Entertainment: Japanese Anime & Manga"},
        {"id" => 32, "name" => "Entertainment: Cartoon & Animations"},
].freeze
end