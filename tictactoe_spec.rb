require './tictactoe.rb'



describe GameModel do 
  describe "#game_over?" do 
  	it "tests for truth" do
  		list = [ ["x","x","x","_","_","_","_","_","_"],["_","_","_","o","o","o","_","_","_"],
               	      ["_","_","_","_","_","_","x","x","x"],["x","_","_","x","_","_","x","_","_"],
             		  ["_","o","_","_","o","_","_","o","_"],["_","_","x","_","_","x","_","_","x"],
             		  ["x","_","_","_","x","_","_","_","x"],["_","_","o","_","o","_","o","_","_"] 
            ]  
        list.each do |e|    
          game = GameModel.new(e)
  	      puts expect( game.game_over? ).to eql(true)
  	    end 	
    end 
    it "tests for falsehood" do
  		list = [ ["x","x","o","_","_","_","_","_","_"],["_","_","_","x","o","o","_","_","_"],
               	      ["_","_","_","_","_","_","x","o","x"],["x","_","_","o","_","_","x","_","_"],
             		  ["_","x","_","_","o","_","_","o","_"],["_","_","o","_","_","x","_","_","x"],
             		  ["x","_","_","_","o","_","_","_","x"],["_","_","x","_","o","_","o","_","_"] 
            ]  
        list.each do |e|    
          game = GameModel.new(e)
          puts ""
  	      puts 'false' if expect( game.game_over? ).to eql(false)
  	    end 	
    end 
    it "tests for board full" do
      game = GameModel.new( ["x","o","x","o","x","o","x","o","x"] )
      expect( game.game_over? ).to eql(true)
    end      
  end 
  
  describe "#is_legal?" do
    it "tests for legal moves" do 
      game = GameModel.new( ["x","o","x","_","_","_","o","_","_"] )
      expect( game.is_legal?(4) ).to eql(true)
    end
    it "tests for legal moves" do 
      game = GameModel.new( ["x","o","x","_","_","_","o","_","_"] )
      expect( game.is_legal?(0) ).to eql(false)
    end
    it "tests for legal moves" do 
      game = GameModel.new( ["x","o","x","_","_","_","o","_","_"] )
      expect( game.is_legal?(1) ).to eql(false)
    end 
  end

  describe "#put_piece" do
    it "tests that the board can be changed correctly" do
      game = GameModel.new( ["_","_","x","_","_","_","o","_","_"] )
      game.put_piece(0)
      game.put_piece(1)
      expect( game.get_piece(0) ).to eql("x")
      expect( game.get_piece(1) ).to eql("o")
    end 
  end 


end 

describe ViewDialogue do 
  describe "#input_allowed?" do 
    it "tests for legal inputs" do
      interface = ViewDialogue.new
      game =GameModel.new
      expect( interface.input_allowed?(1,game) ).to eql(true)
      expect( interface.input_allowed?(10,game) ).to eql(false)
      

    end 
  end 
end

=begin
describe ViewDrawer do
  describe "#draw_board" do 
    it "tests input output" do
      view = ViewDrawer.new
      state = GameModel.new
      expect(view).to receive(:draw_board).with(state).and_return(nil)
      #view.draw_board(state) 
    end 
  end 
end 
=end 
