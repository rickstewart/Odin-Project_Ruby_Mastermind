class AISupport

  def initialize
    @COLORS = %w(red green blue yellow orange purple)
    @secret_code = Array.new
    @user_guesses = Array.new
  end

  def user_guesses
    @user_guesses
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
    # removes any hits from test 1 so they do not get counted twice
    found.each { |value| code.slice!(code.index(value)) }
    #second test catches hits for color found in wrong position
    guess.each do |color|
      if code.include? color
        result[1] += 1
        code.slice! code.index(color)
      end
    end
    @user_guesses << [guess, result]
    result
  end

  def validate_input(guess)
    guess.each do |value|
      if @COLORS.include? value
      else
        return false
      end
    end
  end

  def get_user_guess(round)
    puts ""
    puts "This is round #{round}."
    puts "The colors are: red, green, blue, yellow, orange, and purple."
    puts "Pick four colors, for example, red green yellow red: "
    guess = gets.split(" ")
    guess.map(&:downcase)
  end

  def welcome
    puts ""
    puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
    puts "| The game is Mastermind.                                                                        |".colorize(:color => :green, :background => :cyan)
    puts "| Your challenge is to guess four randomly generated colors.                                     |".colorize(:color => :green, :background => :cyan)
    puts "| The possible colors are: red, green, blue, yellow, orange, and purple.                         |".colorize(:color => :green, :background => :cyan)
    puts "| You will have ten rounds to deduce the four colors and their order.                            |".colorize(:color => :green, :background => :cyan)
    puts "| At the end of each round you will be told how many of your guesses picked                      |".colorize(:color => :green, :background => :cyan)
    puts "| the correct color along with the correct location, and how many correct                        |".colorize(:color => :green, :background => :cyan)
    puts "| colors but in the wrong location.                                                              |".colorize(:color => :green, :background => :cyan)
    puts "|                                                                                                |".colorize(:color => :green, :background => :cyan)
    puts "| Good Luck!                                                                                     |".colorize(:color => :green, :background => :cyan)
    puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
  end

  def display_results(result)
    @user_guesses.each_with_index do |guess,i|
      puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
      puts "| Round #{i+1} |  #{guess[0][0]}  #{guess[0][1]}  #{guess[0][2]}  #{guess[0][3]} | #{result[1][0]} correct color and position | #{result[1][1]} correct color only"
    end
    puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
  end
end
