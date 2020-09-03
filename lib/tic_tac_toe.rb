WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn = 0
  board.each do |index|
    if index == "X" || index == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  #if the turn count is an even number, that means O just went, so the next/current player is X
  num_turns = turn_count(board)
  if num_turns % 2 == 0
    player = "X"  
    # set a new variable called player set to be either X or O ONLY 
  else
    player = "O"
  end
  return player 
  #at the end it returns the value of the player variable that we set earlier in the method, which is either X or O
end

def turn(board)
  puts "Please choose a number 1-9:" #ask user for their move by posotion 1-9
  user_input = gets.chomp   #recieves user input
  index = input_to_index(user_input)   #converts input to index 
  if valid_move?(board, index)    #if move is valid
    player_token = current_player(board)    #uses this method to refer to the current player who is making the move 
    move(board, index, player_token)   #make the move 
    display_board(board)    #and display the board 
  else
    turn(board)   #otherwise ask for new position until valid move recieved 
  end
end

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true  # until game is over 
    turn(board)   # take turns 
  end

  if won?(board)   #if game was won 
    puts "Congratulations #{winner(board)}!"  # congratulate wommer 
  elsif draw?(board) 
    puts "Cat's Game!"
  end
end