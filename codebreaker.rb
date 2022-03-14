
module Codebreaker
  extend self

  @@last_guess = ["","","",""]
  @@random_n = ""

  def guess(code)
    unless code.is_a? Array
      @@last_guess = code.split("")
    else 
      @@last_guess = code
    end
  end

  def random_num()
    @@random_n = Random.new.rand(1..6).to_s
  end

  def rand_guess()
    @@last_guess.each_index do |num|
      if @@last_guess[num] == ""
        random_num()
        @@last_guess[num] = @@random_n
      end
    end
    return @@last_guess
  end
end
