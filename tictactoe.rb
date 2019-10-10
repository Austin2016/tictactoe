

class ViewDrawer  #board UI 
   

  def draw_board(state) # takes an array from game model object that describes the board 
                       
    for row in 0..2 
      for col in 0..2
        square_number = row * 3 + (col + 1)
        square_char = state.get_piece(square_number - 1)         # numbers show the user what keys to hit to place a letter
        if square_char == "x" || square_char == "o"
          print square_char 
        else 
          print square_number.to_s
        end
        if col !=2 
          print "|"
        end 
      end 
      print "\n"
      if row !=2
        print"-----\n"
      end 
    end
  end    
end 

class ViewDialogue     # dialogue ui to prompt and get (valid) inputs from user  

	def get_input(state) #p paramater comes from game model object, tracks turns 
    if state.player == 0 
		  puts "Player 1, choose a numbered square to place your X on!"
    elsif state.player == 1 
      puts "Player 2, choose a numbered square to put your O on!"
    end 
    
           
    condition = true 
    while condition             
      i = gets.chomp.to_i   
      if input_allowed?(i,state)     
        puts "You selected square: #{@i}"	
        puts " "
        puts "Current Board: "	
        puts " "
        condition = false 
        return i
      else 
        puts "invalid entry, try again!"
      end
    end    
	end  

  def play_again? 
    puts "do you want to play again? choose y or no."
    play = gets.chomp
    unless play == "y" || play == "n"
      puts "you entered an invalid resonse.\n"
      self.play_again?
    end
    play == "y" ? true : false  
  end 
  
  def show_result(result)
    case result
    when "x"
      puts "X wins! CONGRATS XXXXXXXXX"
    when "o"
      puts "O wins! CONGRATS OOOOOOOOO"
    when "d"
      puts "It's a DRAWWWWWWW"
    else 
    end 
  end 

  def intro
    puts "\n" 
    puts "Get READDDDYYYY TO PLAYYYYYY!!!\n\n" 
  end  
  
  private 



  def input_allowed? (input,state)  #checks if the user input is one of the valid numbers on board 
    state.is_legal?(input - 1)
  end


end 



class GameModel #tracks the board state, turn state ,determines if game is over and who won 
  
  attr_reader :player

  
  def initialize  

  	@board = ["_","_","_","_","_","_","_","_","_"]

  	@player = 0                                    
  
  end 

  def is_legal? (square)  #checks if the user input is one of the valid numbers on board 
    if [0,1,2,3,4,5,6,7,8].include?(square) == false || @board[square] =="x" || @board[square] =="o"
      return false 
    end 
    true           
  end
  
  def put_piece(square)
    @board[square] = player_symbol(player)
    @player = player_to_opponent(player)   
  end 

  def get_piece(square)
    @board[square]
  end

  
  
  def game_over?   
    if did_player_win?("x") == true || did_player_win?("o") == true || board_full? == true
      return true 
    end 
    return false 
  end 
  
  def result 
    if did_player_win?("x")
      #puts "X won, game over!"
      return "x"
    elsif did_player_win?("o")
      #puts "O won, game over!"
      return "o"
    elsif board_full?
      #puts "it's a drawwwwww!!!!!!!"
      return "d"
    end 
  end 
   
  private 
  
  def vector_win?(start,delta,p) # starting square, step to next square, player (x or o) 
    return @board[start] == p && @board[start+delta]== p && @board[start + delta + delta] == p 
  end

  def did_player_win?(p) 
    array = [ 
      vector_win?(0,1,p), # check row wins 
      vector_win?(3,1,p),
      vector_win?(6,1,p),
     
      vector_win?(0,3,p), # check column wins 
      vector_win?(1,3,p),
      vector_win?(2,3,p),
      
      vector_win?(0,4,p), # check diag wins 
      vector_win?(2,2,p)
    ] 
    
    return array.any? {|e| e == true }  # 
       
    
  end

  def board_full?  
    if @board.any? {|e| e =="_"} == false 
      return true
    end
    false
  end

  def player_symbol(p)
    p == 0 ? "x" : "o"
  end 

  def player_to_opponent(p)
    1 - p 
  end
 
end 

#main 
play = true              #variable is true if user wants to play 
while play == true
  
  
  board_interface = ViewDrawer.new   
  state = GameModel.new 
  relay = ViewDialogue.new

  relay.intro           # introduces the game 
 

  board_interface.draw_board(state)    #default board with default board state 
  
  puts "\n"

  while state.game_over? == false               
	  answer = relay.get_input(state)   
    state.put_piece(answer - 1)                          
    board_interface.draw_board(state)           
    puts "\n"
  end
  relay.show_result(state.result)                                          
  play = relay.play_again?                    


end






  
#to_do 

  #refactor
     # only use one board model and calculate wins from that - DONE
     # make the code more modular - DONE  
     # write the board as blank to start.  - DONE 
     # don't use recursion like that, use a while loop - DONE 
  # change variable names to make them reflect functionality - DONE 
  #add comments to document code -DONE 
  # rename toggle to player, get rid of if / else in main... -DONE 
  # make it so that the board state and turn never get out of lock  -DONE 
  # change didplayewin? to just return the block any method , cuz it returns true anyway -DONE
  # same thing wiht vectorwin method  #DONE
  # don't expose board or internal data to outside ??? - DONE 
  # add privacy designations and what variables are read only - DONE 
  
  # consult style guidlines and apply  
  #push to git hub 
  #for every class that's mutable , return a read only version of yourself ---<ask about this 



