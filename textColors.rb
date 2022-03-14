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