module Requester

  def select_main_menu_action
    puts "random | scores | exit"
    print ">"
    opt = gets.chomp
  end

  def ask_question(question)
    # show category and difficulty from question
    # show the question
    # show each one of the options
    # grab user input
  end

  def will_save?(score)
    # show user's score
    # ask the user to save the score
    # grab user input
    # prompt the user to give the score a name if there is no name given, set it as Anonymous
  end

  def gets_option(prompt, options)
    # prompt for an input
    # keep going until the user gives a valid option
  end
end
