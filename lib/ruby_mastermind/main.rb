# credit to https://stackoverflow.com/questions/1489183/colorized-ruby-output
# for color code.
class Main
  require_relative "ai_support"
  require_relative "string"
  require "colorize"
  def go
    print "Please enter your name: "
    name = gets.chomp
    puts "==================================================================================================".bold.green.bg_gray
    puts "| Hello #{name}                                                                                     |".green.bg_gray
    puts "| The game is Mastermind.                                                                        |".green.bg_gray
    puts "| #{name}, your challenge is to guess four randomly generated colors.                               |".green.bg_gray
    puts "| The possible colors are: red, green, blue, yellow, orange, and purple.                         |".green.bg_gray
    puts "| You will have ten rounds to deduce the four colors and their order.                            |".green.bg_gray
    puts "| At the end of each round you will be told how many of your guesses picked the correct          |".green.bg_gray
    puts "| color at the correct location, and how many picked the correct color but in the wrong location.|".green.bg_gray
    puts "|                                                                                                |".green.bg_gray
    puts "| Good Luck!                                                                                     |".green.bg_gray
    puts "==================================================================================================".bold.green.bg_gray
    ai = AISupport.new
    ai_code = ai.generate_code
    puts ai_code.inspect
    10.times do |round|
      round += 1
      puts ""
      puts "This is round #{round}.".bold.brown.bg_blue
      puts "For reference the colors are: red, green, blue, yellow, orange, and purple."
      puts "Now, pick four colors, for example red green yellow red: "
      guess = gets.split(" ")
      result = ai.test_guess(guess)
      puts "#{result[0]} hits for correct color and position"
      puts "#{result[1]} hits for correct color but not position"
    end
  end
end
