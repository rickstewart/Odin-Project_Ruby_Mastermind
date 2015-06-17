class Main
  require_relative "support"
  require "colorize"

  def go
    valid = false
    mm = Support.new
    mm.welcome
    role = mm.pick_role
    if role == "cb"
      mm.ai_generate_code
      10.times do |round|
        round += 1
        until valid
          guess = mm.user_get_guess(round)
          valid = mm.validate_input(guess)
          if valid
            result = mm.test_guess(guess)
            mm.display_results(result)
          else
            mm.display_error
          end
        end
        valid = false
        end_game = mm.win_lose_test(round)
        if end_game == "win"
          mm.display_win
          return
        elsif end_game == "lose"
          mm.display_lost
          return
        end
      end
    else
      until valid
        code = mm.user_generate_code
        valid = mm.validate_input(code)
        if !valid
          mm.display_error2
        end
      end
      10.times do |round|
        guess = mm.ai_code_break_attempt(round)
        round += 1
        result = mm.test_guess(guess)
        mm.display_results(result)
        end_game = mm.win_lose_test(round)
        if end_game == "win"
          mm.display_win
          return
        elsif end_game == "lose"
          mm.display_lost
          return
        end
      end
    end
  end
end
