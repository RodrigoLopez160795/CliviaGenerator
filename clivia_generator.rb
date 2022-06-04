require "htmlentities"
require "json"
require 'colorized_string'
require_relative "helpers"
require_relative "requester"
require_relative "get_question"

class CliviaGenerator
include Helpers
include Requester

  def initialize(filename = "scores.json")
    @filename = ARGV.shift || filename
    @score = 0
    @playes_arr = []
    @scores = []
  end

  def start
    load_players
    opt = ""
    loop do
      print_welcome
      opt = select_main_menu_action
      case opt
      when "random" then question
      when "scores" then puts table_scores("Top Scores", ["Name","Score"], @scores)
      when "exit" then puts "Exit"
      else puts ColorizedString["Invalid action"].colorize(:red)
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
    easy = ColorizedString["Easy"].colorize(:light_green)
    medium = ColorizedString["Medium"].colorize(:green)
    hard = ColorizedString["Hard"].colorize(:red)
    puts "Choose a difficulty: #{easy} | #{medium} | #{hard}"
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
    @score = 0
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
        puts ColorizedString["Well done! Your score is #{@score}"].colorize(:light_green)
      else
        puts ColorizedString["#{HTMLEntities.new.decode(answers[answer_index - 1])}...Incorrect"].colorize(:red)
        puts ColorizedString["The correct answer was #{HTMLEntities.new.decode(correct_answer)}"].colorize(:red)
      end

    end
  end

  def save
    puts "Type the name to assign to the score"
    print ">"
    name = gets.chomp
    name = "Unkown" if name.empty?
    @players_arr << {name:name, score:@score}
    File.write(@filename, @players_arr.to_json)
  end

  def load_players
    if File.exist?(@filename)
      @players_arr = JSON.parse(File.read(@filename), simbolize_names: true)
      @scores = JSON.parse(File.read(@filename), simbolize_names: true)
      return
    else
      @players_arr = []
      @scores = []
    end
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
