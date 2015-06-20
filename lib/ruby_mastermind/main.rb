class Main
  require_relative "support"
  require_relative "human"
  require_relative "ai"
  require "colorize"

  def go
    mm = Support.new
    mm.welcome
    role = mm.pick_role
    if role == "cb"
      human = Human.new
      human.play(mm)
    else
     ai = AI.new
     ai.play(mm)
    end
  end
end
