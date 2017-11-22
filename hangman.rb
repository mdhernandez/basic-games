class Hangman
  @solution
  @misses
  @wrong_guesses
  @word

  def initialize(guess = 5)
    @solution = file_ops
	@misses = []
	@wrong_guesses = guess
	r = @solution.size - 1
	@word = Array.new(r, "_")
  end

  def file_ops #project specs request words to be between 5 and 12 letters long
     words = File.readlines "5desk.txt"
	 arr = []
	 words.each do |w|
	   if (w.size >= 5 || w.size <=12)
	     arr.push(w)
	   end
	 end
	 len = arr.size
	 word = arr[rand(len)]
	 return word
  end
  
 def print_word
   word_str = @word.join(" ")
   puts word_str
 end
  
  def game
    puts @solution #testing purposes
	
	while @wrong_guesses > 0
	  wrong = true
	  puts "Guess a letter:"
	  letter = gets.chomp
	  if letter.size > 1
	    letter = letter[0]
	  end
	  letter.downcase!
	  i = 0
	  while i < @solution.size
	    if @solution[i].downcase == letter
		  
		  if @solution[i] < letter
		    letter = letter - 32
		  end
		  @word[i] = letter
		  wrong = false
		end
		i+=1
	  end
	  
	  if wrong
	    if !(@misses.include?(letter))
	      @misses.push(letter)
		end
	    @wrong_guesses -= 1
	  end
	  
	  if @solution.strip == @word.join.to_s
	  puts
	    puts "YOU WIN!"
		@wrong_guesses = -1
	  end
	  
	  if @wrong_guesses == 0
	    puts
	    #puts @word.join.to_s#testing purposes
	    puts "Sorry you lose. The word was:"
		puts @solution
	  elsif @wrong_guesses > 0
	    print_word
	    print "Wrong Letters: "
	    puts @misses.inspect
	    puts "Mistakes before Hanged: #{@wrong_guesses}"
	  end
	end
  end#end game
  
end

def play
  hang = Hangman.new
  hang.game
end

play