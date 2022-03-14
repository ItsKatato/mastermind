def intro()
  intro = <<-INTRO.chomp
Welcome to Mastermind!
  How do you play?
    There are two players: The Codemaker and Codebreaker. 
    The codemaker chooses a secret code with 4 numbers between 1 & 6.
    
    Example:
      #{" 4 ".bluebg} #{" 2 ".redbg} #{" 3 ".yellowbg} #{" 4 ".bluebg} 

    The Codebreaker has to figure out the secret code within 12 attempts.
    Each guess the Codebreaker will get a clue whether their guess includes:
    - a number that's correct and in the right spot
    - A number that's correct and in the wrong spot.

    Example:
      #{" 5 ".purplebg} #{" 2 ".redbg} #{" 5 ".purplebg} #{" 3 ".yellowbg}  #{TextFormating.correct} #{TextFormating.wrong}
        - Correct number in correct spot: #{TextFormating.correct} 
        - Correct number in wrong spot: #{TextFormating.wrong}
 
INTRO
end