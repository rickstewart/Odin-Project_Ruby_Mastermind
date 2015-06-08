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
    secret_code = @secret_code
    @found = []
    @result = [0, 0]
    # first test catches hits for both correct color and position
    guess.each_with_index do |color, i|
      if secret_code[i] == color
        @result[0] += 1
        @found.push(color)
      end
    end
    # removes any hits ( color and position ) from secret_code list
    @found.each { |value| secret_code.slice!(secret_code.index(value)) }
    #second test catches hits for color but wrong position
    guess.each do |color|
      if secret_code.include? color
        @result[1] += 1
        secret_code.slice! secret_code.index(color)
      end
    end
    @result
  end
end
