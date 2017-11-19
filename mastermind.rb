class Mastermind
  @pegs
  @solution
  @colors
  @player
  @white

  def initialize( player = true)
    @pegs = { "Colored" => 0, "White" => 0 }
    @colors = ["RED", "YELLOW", "WHITE", "PURPLE", "ORANGE", "GREEN"]
    @solution = color_rand
	@player = player
	@white = Hash.new
  end
  
  def get_white
    return @white
  end
  
  def reset_white
    @white = Hash.new
  end
  
  def set_solution(arr)
    @solution = arr
  end
  
  def color_rand
    i = 0
	arr = Array.new(4)
    while i < 4
      arr[i] = @colors[rand(6)]
      i+=1
    end
	return arr
  end
  
  def get_colors
    return @colors
  end
  
  def get_player
    return @player
  end
  
  def right_spots(arr)
    i = 0
	skip = []
	while i < 4
	  if arr[i] == @solution[i]
	  skip.push(i)
	  end
	  i+=1
	end
	return skip
  end

  def check (arr)
    correct = true
	i = 0
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
	
	r = 0
	while r < 4 
	  if (!skip.include?(r))
	    q = 0
	    while q < 4
	      if arr[r] == @solution[q] && (!skip.include?(q))
		    @pegs["White"] = @pegs["White"]+1
			skip.push(q)
		    @white[arr[r]] = r
		    #puts @white.inspect#debug
		    break
	      end
		  q+=1
	    end
	  end
	  r+=1
	end
	return correct
  end
  
 

  def print_solution
    puts @solution.inspect
  end
  
  def print_pegs
    puts
    puts "Pegs:"
    puts @pegs.inspect
	puts
  end
  
  def reset_pegs
    @pegs["Colored"] = 0
	@pegs["White"] = 0
  end
end#end of Mastermind

def guesser_instructions
  puts "In this game you are the code-breaker."
  puts "When prompted enter four colors out of six options: Red, Yellow, White, Purple, Orange, and Green."
  puts "Please type all four colors on one line, each seperated by one space."
  puts "You may put a color more than once."
  puts
  puts "After you guess you will see something called Pegs pop up"
  puts "A colored peg means you got a color correct in the right spot"
  puts "A white peg means you guessed a correct color, but it is in a wrong spot."
  puts "Use the pegs to help you crack the code!"
  puts
end

def master_instructions
   puts "In this game you are the code-maker."
   puts "To make your solution, enter four colors out of six options: Red, Yellow, White, Purple, Orange, and Green."
   puts "Please type all four colors on one line, each seperated by one space."
   puts "You may use a color more than once."
   puts
end

def play (master, guesses = 10)
  if(master.class == Mastermind)
  
    i = 1
	correct = false
	
	if(master.get_player)#human player
	  guesser_instructions
	  while((!correct) && i <= guesses)
	  puts "Make your guess!"
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
		print "The solution was: "
		puts master.print_solution
	  end
	
	
	else#computer player
	  cols = master.get_colors
	  hr = [0,1,2,3]
	  stank = Hash.new
	  wer = 0
	  
	  while wer < 4
	    stank[hr[wer]] = cols
	    wer += 1
	  end
	  
	 # puts stank.inspect
	  master_instructions
	  sol = gets.chomp
	  sol.upcase!
	  sole = sol.split(" ")
	  master.set_solution(sole)
	  right_spots = []
	  puts
	  puts "Computer Guesses:"
	  comp_guess = master.color_rand
	  correct = master.check(comp_guess)
	  
	  almost = master.get_white
	  
	  while(!correct && i <= guesses)
	    r = 0
		taken = []
	    puts comp_guess.inspect#debug
	    right_spots = master.right_spots(comp_guess)
		while r < 4
	      if !(right_spots.include?(r))
		    stank[r] = stank[r] - [comp_guess[r]]
		    stank_size = stank[r].size
		 
		    if (!almost.empty?)
			  almost.each do |key, value|
			    if (value != r) && (!taken.include?(r))
			      comp_guess[r] = key
			      taken.push(r)
			    end
			  end
	        end
		  
		    if (!taken.include?(r))
		      comp_guess[r] = stank[r][rand(stank_size)]
		    end
		  end
		  r+=1
        end
		#puts stank.inspect
		master.reset_white
		correct = master.check(comp_guess)
		almost = master.get_white
		i+=1
	  end
	  if(correct)
	    puts comp_guess.inspect#debug
	    puts "The Computer guessed the solution in #{i} guesses."
		puts
	  else
	    puts "The Computer failed to guess the solution after #{i-1} guesses."
		puts
	  end
	end#end player if
  end#end master class if
end

def intro
  
  puts "Mastermind is a code-breaking game where you can play as either the code-breaker or the code-maker."
  puts "As code-breaker, you must break a code consisting of four colors created by a computer player."
  puts "As code-maker, you create the four-color code and the computer player tries to guess the code you created."
  puts "The code-breaker will have ten attempts to crack the code."
  puts
  puts "Welcome to Mastermind!"
  puts
end

def game
  puts
  intro
  choice = -1
  playing = true
  
  while playing
    puts "To play Mastermind as the code-breaker enter 1. To play as the code-maker enter 2\nTo quit enter any other number."
    choice = gets.chomp.to_i
	puts
    case choice
    when 1
      test = Mastermind.new(true)
	  play(test)
    when 2
      test = Mastermind.new(false)
	  play(test)
    else
      puts "Thank you for playing Mastermind!"
	  playing = false
    end
  end
end

game