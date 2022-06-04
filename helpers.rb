require "terminal-table"
require "colorize"

module Helpers
  def print_welcome
    puts "#" * 35
    puts "#   Welcome to Clivia Generator   #"
    puts "#" * 35
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

  def table_scores(title, headings, scores)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    scores.sort_by! { |e| e["score"] }
    scores.reverse!
    table.rows = scores.map do |row|
      [row["name"], row["score"]]
    end
    table
  end

  def ask_for_a_category
    id = ""
    loop do
      puts "Please select a valid ID"
      print ">"
      id = gets.chomp.to_i
      break if id.between?(9, 32) || id == 1

      puts "Invalid ID".colorize(:red)
    end
    id
  end

  def get_category_name(id, categories)
    categories.each do |category|
      return category["name"] if category["id"] == id
    end
  end

  def valid_difficulty
    difficulty = ""
    valid_difficulties = ["easy", "medium", "hard"]
    loop do
      print ">"
      difficulty = gets.chomp.downcase
      break if valid_difficulties.include?(difficulty)

      puts "Invalid difficulty".colorize(:red)
    end

    difficulty
  end

  def scrambled_answers(question)
    question[:incorrect_answers] << question[:correct_answer]
    question[:incorrect_answers].shuffle
  end

  def validate_answer(type)
    valid_answers = type == "multiple" ? %w[1 2 3 4] : %w[1 2]
    answer = ""
    loop do
      print ">"
      answer = gets.chomp
      break if valid_answers.include?(answer)

      puts "Invalid answer. Should be a number between 1 and 4".colorize(:red) if type == "multiple"
      puts "Invalid answer. Should be 1 or 2".colorize(:red) if type == "boolean"
    end
    answer.to_i
  end

  def increment_score(difficulty)
    increment = 0
    case difficulty
    when "easy" then increment = 10
    when "medium" then increment = 15
    when "hard" then increment = 20
    end
    increment
  end

  def validate_save_answer
    puts "Do you want to save your score? (y/n)"
    valid_answers = ["yes", "y", "no", "n"]
    answer = ""
    loop do
      print ">"
      answer = gets.chomp.downcase
      break if valid_answers.include?(answer)

      puts "Invalid answer".colorize(:red)
    end
    return true if ["yes", "y"].include?(answer)

    false
  end
end

module CategoryHash
  CATEGORIES = [
    { "id" => 1, "name" => "Random category" },
    { "id" => 9, "name" => "General Knowledge" },
    { "id" => 10, "name" => "Entertainment: Books" },
    { "id" => 11, "name" => "Entertainment: Film" },
    { "id" => 12, "name" => "Entertainment: Music" },
    { "id" => 13, "name" => "Entertainment: Musicals & Theatres" },
    { "id" => 14, "name" => "Entertainment: Television" },
    { "id" => 15, "name" => "Entertainment: Video Games" },
    { "id" => 16, "name" => "Entertainment: Board Games" },
    { "id" => 17, "name" => "Science & Nature" },
    { "id" => 18, "name" => "Science: Computers" },
    { "id" => 19, "name" => "Science: Mathematics" },
    { "id" => 20, "name" => "Mythology" },
    { "id" => 21, "name" => "Sports" },
    { "id" => 22, "name" => "Geography" },
    { "id" => 23, "name" => "History" },
    { "id" => 24, "name" => "Politics" },
    { "id" => 25, "name" => "Art" },
    { "id" => 26, "name" => "Celebrities" },
    { "id" => 27, "name" => "Animals" },
    { "id" => 28, "name" => "Vehicles" },
    { "id" => 29, "name" => "Entertainment: Comics" },
    { "id" => 30, "name" => "Science: Gadgets" },
    { "id" => 31, "name" => "Entertainment: Japanese Anime & Manga" },
    { "id" => 32, "name" => "Entertainment: Cartoon & Animations" }
  ].freeze
end
