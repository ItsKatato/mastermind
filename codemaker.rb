
module Codemaker
  extend self

  @@secret_code = []

  def create_code(code)
    @@secret_code = code.split("")
  end

  def rand_code()
    code = String.new
    4.times do
      code += Random.new.rand(1..6).to_s
    end
    return code
  end
end
