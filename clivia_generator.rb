# do not forget to require your gem dependencies
require_relative "helpers"
require_relative "requester"
require_relative "get_question"

class CliviaGenerator
include Helpers
include Requester
  
  def initialize(filename = "scores.json")
    @filename = ARGV.shift || filename
  end

  def start
    opt = ""
    print_welcome
    loop do
      opt = select_main_menu_action
      case opt
      when "random" then question
      when "scores" then puts "Scores"
      when "exit" then puts "Exit"
      else puts "Invalid action"
      end
      break if opt == "exit"
    end
  end

  def question
    categories = CategoryHash::CATEGORIES
    puts table_categories("Categories", ["ID","Category"], categories)
    id = ask_for_a_category
    category_name = get_category_name(id, categories)
    puts "You selected #{category_name}"
    puts "Choose a difficulty: Easy | Medium | Hard"
    difficulty = valid_difficulty
    ask_questions(id, difficulty)

  end

  def random_trivia
    # load the questions from the api
    # questions are loaded, then let's ask them
  end

  def ask_questions(id, difficulty)
    p question = GetService::Question.get_question(id, difficulty)
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
  end

  def save(data)
    # write to file the scores data
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    # ask the api for a random set of questions
    # then parse the questions
  end

  def parse_questions
    # questions came with an unexpected structure, clean them to make it usable for our purposes
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end

trivia = CliviaGenerator.new
trivia.start
