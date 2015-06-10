class Main
  require_relative "ai_support"
  require_relative "string"
  require "colorize"

  def go
    valid = false
    ai = AISupport.new
    ai.welcome
    secret_code = ai.generate_code
    puts secret_code.inspect
    10.times do |round|
      round += 1
      until valid
        guess = ai.get_user_guess(round)
        valid = ai.validate_input(guess)
        if valid
          result = ai.test_guess(guess)
          puts "#{result[0]} hits for correct color and position"
          puts "#{result[1]} hits for correct color but wrong position"
        else
          puts "oops... something was wrong with your guess, try again please."
        end
      end
    end
  end
end
