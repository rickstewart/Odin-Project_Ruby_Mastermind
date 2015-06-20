class AI
  def play(mm)
    valid = false
    until valid
      code = mm.human_generate_code
      valid = mm.validate_input(code)
      if !valid
        mm.display_error2
      end
    end
    10.times do |round|
      round += 1
      guess = mm.ai_code_break_attempt(round)
      result = mm.test_guess(guess)
      mm.display_results(result)
      end_game = mm.win_lose_test(round)
      if end_game == "win"
        mm.display_lost
        return
      elsif end_game == "lose"
        mm.display_win
        return
      end
    end
  end
end
