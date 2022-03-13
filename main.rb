module Computer
  def self.rand_code()
    code = String.new
    4.times do
      code += Random.new.rand(1..6).to_s
    end
    return code
  end
end

module Play
  extend self

  @@clue = String.new
  @@color_guess = String.new
  @@broken = false

  @@last_guess = []
  @@secret_code = []

  def last_guess()
    return @@last_guess
  end

  def secret_code()
    return @@secret_code
  end

  def guess_test(guess,code)
    @@clue.clear
    if guess.eql?(code)
      4.times {@@clue += TextFormating.correct + " "}
      return @@clue
    end
    guess.each_index do |i|
      if guess[i] == code[i]
        @@clue += TextFormating.correct + " "
      elsif code.include?(guess[i])
        @@clue += TextFormating.wrong + " "
      end
    end
    if @@clue.empty?
      @@clue += "\u2717"
    end

    return @@clue
  end

  def show_guess(guess)
    @@color_guess.clear
    guess.each do |g|
      case g 
      when "1"
        @@color_guess += " #{g} ".redbg + " "
      when "2"
        @@color_guess += " #{g} ".greenbg + " "
      when "3"
        @@color_guess += " #{g} ".yellowbg + " "
      when "4"
        @@color_guess += " #{g} ".bluebg + " "
      when "5"
        @@color_guess += " #{g} ".purplebg + " "
      when "6"
        @@color_guess += " #{g} ".cyanbg + " "
      end
    end
    return @@color_guess
  end

  def round_results()
    return "#{@@color_guess} #{@@clue}"
  end

  def exact?(guess,code)
    if guess.eql?(code)
      puts "The secret code has been guessed!"
      return true
    else 
      return false
    end
  end

  def play_round(guess, code)
    guess_test(guess, code)
    show_guess(guess)
    round_results()
  end

  def game_loop_hum()
    for i in 1..12 do
      puts "Type in 4 numbers (1-6) as your guess."
      Codebreaker.guess(gets.chomp)
      if @@last_guess.any? {|n| n.to_i < 1 || n.to_i > 9 || /\D/.match?(n)}
        redo
      end
      puts play_round(@@last_guess, @@secret_code)
      if exact?(@@last_guess, @@secret_code)
        break
      end
    end
  end

end


class Codebreaker
  include Play

  def initialize()
  end

  def self.guess(code)
    @@last_guess = code.split("")
  end
end

class Codemaker
  include Play 
  include Computer 

  def initialize()
  end

  def self.create_code(code)
    @@secret_code = code.split("")
  end
end

class String
  def red
    "\e[0;31m#{self}\e[0m"
  end

  def green
    "\e[0;32m#{self}\e[0m"
  end

  def yellow
    "\e[0;33m#{self}\e[0m"
  end

  def blue
    "\e[0;34m#{self}\e[0m"
  end

  def purple
    "\e[0;35m#{self}\e[0m"
  end

  def cyan
    "\e[0;36m#{self}\e[0m"
  end

  def redbg
    "\e[0;41m#{self}\e[0m"
  end

  def greenbg
    "\e[0;42m#{self}\e[0m"
  end

  def yellowbg
    "\e[0;43m#{self}\e[0m"
  end

  def bluebg
    "\e[0;44m#{self}\e[0m"
  end

  def purplebg
    "\e[0;45m#{self}\e[0m"
  end

  def cyanbg
    "\e[0;46m#{self}\e[0m"
  end

end

module TextFormating
  @@CIRCLE = "\u25CF"

  def self.correct()
    return @@CIRCLE.green
  end

  def self.wrong()
    return @@CIRCLE.yellow
  end
end

$code_breaker = Codebreaker.new()
$code_maker = Codemaker.new()


Codemaker.create_code(Computer.rand_code())
Play.game_loop_hum
puts "The secret code was " + Play.secret_code().join("") + "!"


