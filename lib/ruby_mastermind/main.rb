class Main
  require_relative "ai_support"
  require "colorize"

  def go
    valid = false
    ai = AISupport.new
    ai.welcome
    ai.generate_code
    10.times do |round|
      round += 1
      until valid
        guess = ai.get_user_guess(round)
        valid = ai.validate_input(guess)
        if valid
          result = ai.test_guess(guess)
          ai.display_results(result)
        else
          puts "oops... something was wrong with your guess, try again please."
        end
      end
      valid = false
    end
  end
end
