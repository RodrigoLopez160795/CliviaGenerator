require "htmlentities"
require_relative "helpers"
require_relative "requester"
require_relative "get_question"

class CliviaGenerator
include Helpers
include Requester
  
  def initialize(filename = "scores.json")
    @filename = ARGV.shift || 
    @score = 0
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
    questions = load_questions(id, difficulty)
    display_questions(questions, difficulty)
    puts "-"*50
    save_opt = validate_save_answer
    save_opt && save
  end

  def load_questions(id, difficulty)
    questions = GetService::Question.get_question(id, difficulty)
    questions[:results]
  end

  def display_questions(questions, difficulty)
    questions.each do |question|
      correct_index = 0
      correct_answer = ""
     
      answers = scrambled_answers(question)
      puts HTMLEntities.new.decode(question[:question])
      answers.each_with_index do |answer, index|
        puts "#{index + 1}. #{HTMLEntities.new.decode(answer)}"
        if question[:correct_answer] == answer
          correct_index = (index + 1)
          correct_answer = answer
        end
      end
      answer_index = validate_answer(question[:type])
      if answer_index == correct_index
        @score += increment_score(difficulty)
        puts "Well done! Your score is #{@score}"
      else
        puts "#{HTMLEntities.new.decode(answers[answer_index - 1])}...Incorrect"
        puts "The correct answer was #{HTMLEntities.new.decode(correct_answer)}"
      end

    end
  end

  def save
    puts "Type the name to assign to the score"
    print ">"
    name = gets.chomp
  end

  def parse_scores
    # get the scores data from file
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
