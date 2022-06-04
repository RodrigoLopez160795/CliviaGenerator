module Requester
  def select_main_menu_action
    puts "Random | Scores | Exit"
    print ">"
    gets.chomp.downcase
  end
end
