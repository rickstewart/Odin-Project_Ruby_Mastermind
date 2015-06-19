class Support

  def initialize
    @COLORS = %w(red green blue yellow orange purple)
    @secret_code = Array.new
    @user_guesses = Array.new
    @ai_guess = Array.new
  end

  def pick_role
    while true
      puts ""
      puts "What role will you play? For 'CodeBreaker' type cb and for 'CodeMaker' type cm:"
      role = gets.chomp
      role.downcase
      if (role == 'cb') || (role == 'cm')
        return role
      else
        puts "oops... something was wrong with your answer, please pick 'cb' or 'cm'."
      end
    end
  end

  def ai_generate_code
    4.times { @secret_code.push(@COLORS.sample) }
    @secret_code
  end

  def user_generate_code
    puts ""
    puts "The colors are: red, green, blue, yellow, orange, and purple."
    puts "Pick four colors, for example, red green yellow red: "
    @secret_code = gets.split(" ")
    @secret_code.map(&:downcase)
  end

  def user_get_guess(round)
    puts ""
    puts "This is round #{round}."
    puts "The colors are: red, green, blue, yellow, orange, and purple."
    puts "Pick four colors, for example, red green yellow red: "
    guess = gets.split(" ")
    guess.map(&:downcase)
  end

  def add_guess_history(guess, result)
    @user_guesses << [guess, result]
    @user_guesses
  end

  def validate_input(guess)
    if (guess.count == 4)
      guess.each do |value|
        if (@COLORS.include? value)
        else
          return false
        end
      end
    else
      return false
    end
    return true
  end

  def test_guess(guess)
    code = @secret_code.clone
    found = []
    result = [0, 0]
    # first test catches hits for correct color and position
    guess.each_with_index do |color, i|
      if code[i] == color
        result[0] += 1
        found.push(color)
      end
    end
    # removes any hits from test 1 so they do not get counted twice
    found.each { |value| code.slice!(code.index(value)) }
    #second test catches hits for color only, but wrong position
    guess.each do |color|
      if code.include? color
        result[1] += 1
        code.slice! code.index(color)
      end
    end
    add_guess_history(guess, result)
  end

  def ai_code_break_attempt(round)
    if round == 0
      4.times { @ai_guess << 'red' }
    elsif (@user_guesses[round-1][1][0] + @user_guesses[round-1][1][1]) < 4
      wrong = 4 - (@user_guesses[round-1][1][0] + @user_guesses[round-1][1][1])
      wrong.times { |i| @ai_guess[i] = @COLORS[(round) % 6] }
    else
      @ai_guess.shuffle!
    end
    @ai_guess
  end

  def win_lose_test(round)
    user_guess = @user_guesses
    if user_guess[round-1][1][0] == 4
      "win"
    elsif round == 10
      "lose"
    end
  end

  def welcome
    puts ""
    puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
    puts "| The game is Mastermind.                                                                        |".colorize(:color => :green, :background => :cyan)
    puts "|                                                                                                |".colorize(:color => :green, :background => :cyan)
    puts "| As 'CodeBreaker' your challenge is to guess four randomly generated colors.                    |".colorize(:color => :green, :background => :cyan)
    puts "| The possible colors are: red, green, blue, yellow, orange, and purple.                         |".colorize(:color => :green, :background => :cyan)
    puts "| You will have ten rounds to deduce the four colors and their order.                            |".colorize(:color => :green, :background => :cyan)
    puts "| At the end of each round you will be told how many of your guesses picked                      |".colorize(:color => :green, :background => :cyan)
    puts "| the correct color along with the correct location, and how many correct                        |".colorize(:color => :green, :background => :cyan)
    puts "| colors but in the wrong location.                                                              |".colorize(:color => :green, :background => :cyan)
    puts "|                                                                                                |".colorize(:color => :green, :background => :cyan)
    puts "| As 'CodeMaker' your challenge is to generate a secret code consisting of any                   |".colorize(:color => :green, :background => :cyan)
    puts "| combination of four colors picked from a palette of six. The computer AI will                  |".colorize(:color => :green, :background => :cyan)
    puts "| then try to guess your secret code.                                                            |".colorize(:color => :green, :background => :cyan)
    puts "|                                                                                                |".colorize(:color => :green, :background => :cyan)
    puts "| Good Luck!                                                                                     |".colorize(:color => :green, :background => :cyan)
    puts "==================================================================================================".colorize(:color => :green, :background => :cyan)
  end

  def display_error
    puts "oops... something was wrong with your guess, try again please."
  end

  def display_error2
    puts "oops... something was wrong with your code, try again please."
  end

  def display_results(result)
    puts "-------------------------------------------- Mastermind --------------------------------------------".colorize(:color => :green, :background => :cyan)
    result.each_with_index do |guess, i|
      puts "%-11s" % "| Round #{i+1} " + "|  " + "%-32s" % "#{guess[0][0]}  #{guess[0][1]}  #{guess[0][2]}  #{guess[0][3]} " + "| #{guess[1][0]} correct color and position | #{guess[1][1]} correct color only"
    end
    puts "----------------------------------------------------------------------------------------------------".colorize(:color => :green, :background => :cyan)
    puts ""
  end

  def display_win
    puts "------------------------------------ Congratulations! You Won! -------------------------------------".colorize(:color => :white, :background => :black)
  end

  def display_lost
    puts "------------------------------------- Sorry, Computer AI wins! -------------------------------------".colorize(:color => :white, :background => :black)
  end
end
