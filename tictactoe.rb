class Game
  @board
  @gamefinish
  @winner
  def initialize()
    @gamefinish = false
    @board = Array.new(3) {Array.new(3, "-")}
	@winner = "Nobody"
	i = 0
	r = 1
	while i < 3
	  q = 0
	  while q < 3
	    @board[i][q] = r
		r+=1
		q+=1
	  end
	  i+=1
	end
  end
  
  def game_won?
    i = 0
	while i < 3
	  if (@board[i][0] == @board[i][1] && @board[i][1] == @board[i][2])
        @winner = @board[i][0]
		return true
	  elsif (@board[0][i] == @board[1][i] && @board[1][i] == @board[2][i])
	    @winner = @board[0][i]
		return true
	  end
	i+=1
	end
	
	if((@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||(@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]))
	  @winner = @board[1][1]
	  return true
	end
	return false
  end
  
  def move (num, player)
    if player == 1
	  mover = 'X'
	else
	  mover = 'O'
	end
	
    case num
	when 1
	  @board[0][0] = mover
	when 2
	  @board[0][1] = mover
	when 3
	  @board[0][2] = mover
	when 4
	  @board[1][0] = mover
	when 5
	  @board[1][1] = mover
	when 6
	  @board[1][2] = mover
	when 7
	  @board[2][0] = mover
	when 8
	  @board[2][1] = mover
	when 9
	  @board[2][2] = mover
	end
  end
  
  def valid_move? (num)
    valid = false
	case num
	when 1
	  if !((@board[0][0] == 'X') || (@board[0][0] == 'O'))
	    valid = true
	  end
	when 2
	  if !((@board[0][1] == 'X') || (@board[0][1] == 'O'))
	    valid = true
	  end
	when 3
	  if !((@board[0][2] == 'X') || (@board[0][2] == 'O'))
	    valid = true
	  end
	when 4
	  if !((@board[1][0] == 'X') || (@board[1][0] == 'O'))
	    valid = true
	  end
	when 5
	  if !((@board[1][1] == 'X') || (@board[1][1] == 'O'))
	    valid = true
	  end
	when 6
	  if !((@board[1][2] == 'X') || (@board[1][2] == 'O'))
	    valid = true
	  end
	when 7
	  if !((@board[2][0] == 'X') || (@board[2][0] == 'O'))
	    valid = true
	  end
	when 8
	  if !((@board[2][1] == 'X') || (@board[2][1] == 'O'))
	    valid = true
	  end
	when 9
	  if !((@board[2][2] == 'X') || (@board[2][2] == 'O'))
	    valid = true
	  end
	end
	return valid
  end
  
  def print_board
    i = 0
	while i < 3
	  puts "#{@board[i][0]} #{@board[i][1]} #{@board[i][2]}"
	  i+=1
	end
  end
  
end#end Class

def play (game)
  puts "Welcome to Tic-Tac-Toe!"
  puts "Enter a number between 1 - 9 to play. To Exit enter anything else."
  
  if(game.class == Game)
    turn = 0
	
    while ((!game.game_won?) && turn < 9)
	  game.print_board
	  player = (turn % 2) + 1
	  puts "Player #{player}'s Turn!"
	  puts "Enter the number of a space to take your turn."
	  num = gets.chomp.to_i
	  
	  if !(num > 0 && num < 10)
	   return
	   end
	   
	  if game.valid_move?(num)
	    game.move(num, (turn % 2))
	    turn += 1
	  else
	    puts "Invalid move. Try again."
	  end 
	end
	
	game.print_board
	
	if game.game_won?
	puts "The game is over! Player #{(turn - 1)%2 + 1} has won!"
	else
	puts "The game is a Draw!"
	end
  end
end

ticTac = Game.new
play(ticTac)
