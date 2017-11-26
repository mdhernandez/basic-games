require "yaml"

class Hangman 
  @solution
  @misses
  @wrong_guesses
  @word

  def initialize(guess = 5)
    @solution = file_ops
	@misses = []
	@wrong_guesses = guess
	r = @solution.size
	@word = Array.new(r, "_")
  end

  def file_ops #project specs request words to be between 5 and 12 letters long
     words = File.readlines "5desk.txt"
	 arr = []
	 words.each do |w|
	   w.strip!
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
 
   def game_status
     print_word
	 print "Wrong Letters: "
	 puts @misses.inspect
	 puts "Mistakes before Hanged: #{@wrong_guesses}"
   end
  
  def game 
    #puts @solution #testing purposes
	puts "You can save at anytime by entering the word 'save'."
	game_status
	
	while @wrong_guesses > 0
	  wrong = true
	  puts "Guess a letter:"
	  letter = gets.chomp
	  if letter.downcase == "save"
	    save_game
		return
	  end
	  if letter.size > 1
	    letter = letter[0]
	  end
	  letter.downcase!
	  i = 0
	  while i < @solution.size
	    if @solution[i].downcase == letter
		  
		  if @solution[i] < letter
		    letter.upcase!
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
	  
	  if @solution == @word.join.to_s
	  puts
	    puts "YOU WIN!"
		@wrong_guesses = -1
	  end
	  
	  if @wrong_guesses == 0
	    puts
	    puts "Sorry you lose. The word was:"
		puts @solution
	  elsif @wrong_guesses > 0
	    game_status
	  end
	end
  end
  
  def save_game
    save_data = YAML::dump(self)
	aFile = File.open("save_data/save_data.txt", "w")
	aFile.syswrite(save_data)
  end
  
  def load_game
    aFile = File.open("save_data/save_data.txt", "r")
	
    if (!(File.exists?(aFile))) ||  File.zero?(aFile)
	  puts "No save exists."
	  return nil
	end
	
	save_data = YAML::load(aFile)
	return save_data
  end
  
end

def play
  hang = Hangman.new
  puts "1) New Game"
  puts "2) Continue"
  choice = gets.chomp.to_i
  
  case choice
  when 1
    hang.game
  when 2
    save = hang.load_game
	if save
	  save.game
	else
	end
  else
    return nil
  end
end

play