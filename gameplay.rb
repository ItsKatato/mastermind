
module Play
  include Codebreaker , Codemaker
  extend self

  @@clue = String.new
  @@color_guess = String.new
  @@broken = false
  @@random_n = ""


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
      if @@last_guess.any? {|n| n.to_i < 1 || n.to_i > 6 || /\D/.match?(n)}
        redo
      end
      if @@last_guess.length > 4
        redo
      end
      puts play_round(@@last_guess, @@secret_code)
      if exact?(@@last_guess, @@secret_code)
        break
      end
    end
  end

  def game_loop_com()
    puts "The computer will begin to guess."
    for i in 1..12 do
      sleep(2)
      Codebreaker.guess(Codebreaker.rand_guess())
      puts play_round(@@last_guess, @@secret_code)
      analyze_g(@@last_guess, @@secret_code)
      if exact?(@@last_guess, @@secret_code)
        break
      end
    end
    puts "The computer couldn't guess the secret code! Great job!"
  end

  
  def analyze_g(guess,code)
    guess.each_index do |i|
      if guess[i] == code[i]
        next
      else
        guess[i] = ""
      end
    end
  end

  def gameplay()
    puts "Would you like to be the Codemaker or Codebreaker?\n[1] Codemaker\n[2] Codebreaker"
    loop do
      answer = gets.chomp
      if answer == "1"
        puts "You chose [1] Codemaker!\n What would you like your secret code to be? it has to be 4 numbers (1-6)."
        loop do
          secret_code = gets.chomp
          Codemaker.create_code(secret_code)
          if Play.secret_code().any? {|n| n.to_i < 1 || n.to_i > 6 || /\D/.match?(n)}
            puts "The secret code can only contain numbers that are 1-6. Please try again."
            redo
          elsif Play.secret_code().length > 4 || Play.secret_code().length < 4
            puts "The secret code has to be 4 numbers. Please try again."
            redo
          else
            Play.game_loop_com
            break
          end
        end
      elsif answer == "2"
        Codemaker.create_code(Play.rand_code())
        Play.game_loop_hum
        puts "The secret code was " + Play.secret_code().join("") + "!"
        break 
      else
        puts "You have to pick either 1 or 2!"
        redo
      end
      break
    end
  end

end