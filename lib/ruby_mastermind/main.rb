class Main
  require_relative "ai_support"
  require "colorize"

  def go
    valid = false
    ai = AISupport.new
    ai.welcome
    role = ai.pick_role
    if role == "cb"
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
            ai.display_error
          end
        end
        valid = false
        end_game = ai.win_lose_test(round)
        if end_game == "win"
          ai.display_win
          return
        elsif end_game == "lose"
          ai.display_lost
          return
        end
      end
    else
      until valid
        code = ai.pick_secret_code
        valid = ai.validate_input(code)
        if !valid
          ai.display_error2
        end
      end
      10.times do |round|
        round += 1
        guess = ai.code_break_attempt(round)
        result = ai.test_guess(guess)
        ai.display_results(result)
        end_game = ai.win_lose_test(round)
        if end_game == "win"
          ai.display_win
          return
        elsif end_game == "lose"
          ai.display_lost
          return
        end
      end
    end
  end
end
