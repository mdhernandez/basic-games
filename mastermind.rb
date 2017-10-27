class Mastermind
  @pegs
  @turn
  @solution
  @colors

  def initialize()
    @pegs = { "Colored" => 0, "White" => 0 }
    @colors = ["RED", "YELLOW", "WHITE", "PURPLE", "ORANGE", "GREEN"]
    @solution = Array.new(4)
    i = 0
    while i < 4
      @solution[i] = @colors[rand(6)]
      i+=1
    end
  end

  def check (arr)
    correct = true
	i = 0
	r = 0
	skip = []
	while i < 4
	  if arr[i] == @solution[i]
	    skip.push(i)
		@pegs["Colored"] = @pegs["Colored"] + 1
	  else
	    correct = false
	  end
	  i+=1
	end
	
	while r < 4 
	  q = 0
	  while q < 4
	    if arr[r] == @solution[q] && (!skip.include?(q))
		  @pegs["White"] = @pegs["White"]+1
	    end
		q+=1
	  end
	  r+=1
	end
	
	return correct
  end

  def print_solution
    puts @solution.inspect
  end#test purposes
  
  def print_pegs
    puts @pegs.inspect
  end
  
  def reset_pegs
    @pegs["Colored"] = 0
	@pegs["White"] = 0
  end
end#end Mastermind class

def guesser_instructions
  puts "Welcome to Mastermind!"
  puts "When prompted enter four colors out of six options: Red, Yellow, White, Purple, Orange, and Green"
  puts "Please type all four colors on one line, each seperated by one space."
end

def play (master)
  if(master.class == Mastermind)
	guesser_instructions
	
	
	i = 1
	
	correct = false
	while((!correct) && i <= 10)#change 10 to variable later
	guess = gets.chomp
	guess.upcase!
	guess_arr = guess.split(" ")
	  correct = master.check(guess_arr)
	  if correct
	    puts "Congratulations! You've Won!"
	  else
	    master.print_pegs
	    master.reset_pegs
	  end
	  i += 1
	end
	if i == 11 && (!correct)
	  puts "I'm Sorry. You Lose."
	end
  end
end

nword = Mastermind.new
nword.print_solution
play(nword)