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

def turn(board, current_player = "X")
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    "Choose an unoccupied space!"
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def play(board)
  display_board(board)
  while !over?(board)
    turn(board)
  end
  if (draw?(board))
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

#GAME STATUS

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  board_x = board.each_index.select{ |i| board[i] == "X" }
  board_o = board.each_index.select{ |i| board[i] == "O" }
  result = false
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all?{ |w| board_x.include?(w) } || win_combination.all?{ |w| board_o.include?(w)}
      result = win_combination
      break;
    end
  end
  result
end

def full?(board)
  board.all?{ |b| b != " " && b != "" && b != nil}
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  else
    nil
  end
end

#END GAME STATUS
