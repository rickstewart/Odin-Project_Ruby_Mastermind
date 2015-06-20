class Human

  def play(mm)
    mm.ai_generate_code
    10.times do |round|
      valid = false
      round += 1
      until valid
        guess = mm.get_human_guess(round)
        valid = mm.validate_input(guess)
        if valid
          result = mm.test_guess(guess)
          mm.display_results(result)
        else
          mm.display_error
        end
      end
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
