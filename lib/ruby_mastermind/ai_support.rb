class AISupport

  def initialize
    @COLORS = %w(red green blue yellow orange purple)
    @secret_code = Array.new
  end

  def generate_code
    4.times { @secret_code.push(@COLORS.sample) }
    @secret_code
  end

  def test_guess(guess)
    code = @secret_code.clone
    found = []
    result = [0, 0]
    # first test catches hits for both correct color and position
    guess.each_with_index do |color, i|
      if code[i] == color
        result[0] += 1
        found.push(color)
      end
    end
    # removes any hits from test 1
    found.each { |value| code.slice!(code.index(value)) }
    #second test catches hits for color but wrong position
    guess.each do |color|
      if code.include? color.downcase
        result[1] += 1
        code.slice! code.index(color.downcase)
      end
    end
    result
  end

  def validate_input(guess)
    guess.each do |value|
      if @COLORS.include? value.downcase
      else
        return false
      end
    end
  end

  def get_user_guess(round)
    puts ""
    puts "This is round #{round}."
    puts "For reference the colors are: red, green, blue, yellow, orange, and purple."
    puts "Now, pick four colors, for example red green yellow red: "
    gets.split(" ")
  end

  def welcome
    puts ""
    puts "==================================================================================================".bold.green.bg_gray
    puts "| The game is Mastermind.                                                                        |".green.bg_gray
    puts "| Your challenge is to guess four randomly generated colors.                                     |".green.bg_gray
    puts "| The possible colors are: red, green, blue, yellow, orange, and purple.                         |".green.bg_gray
    puts "| You will have ten rounds to deduce the four colors and their order.                            |".green.bg_gray
    puts "| At the end of each round you will be told how many of your guesses picked                      |".green.bg_gray
    puts "| the correct color along with the correct location, and how many correct                        |".green.bg_gray
    puts "| colors but in the wrong location.                                                              |".green.bg_gray
    puts "|                                                                                                |".green.bg_gray
    puts "| Good Luck!                                                                                     |".green.bg_gray
    puts "==================================================================================================".bold.green.bg_gray
  end
end
