class TicTacToe
  attr_accessor :player1, :player2, :gameboard, :current_player

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @gameboard = Gameboard.new
    @current_player = @player1
  end

  def look_for_winner
  end

  def print_winner
  end

  def next_turn
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def place_token(location)
    gameboard.slots[location] = Token.new(current_player.player_id)
  end
  
  class Player
    attr_accessor :player_id

  	@@player_count = 0
  	
  	def initialize
      @@player_count += 1
      @player_id = "player#{@@player_count}"
  	end    
  end


  class Gameboard
    attr_accessor :slots
  	
  	def initialize
  	  @slots = (1..9).to_a
      @slots.map! { |slot| slot = "empty slot" }
  	end

    def draw_board
      slots.each_with_index do |slot, index|
        if index + 1 == 3 || index + 1 == 6 || index + 1 == 9    
          if slot.class == Token
            puts "| #{slot.token_model} |"
          else
            puts "|   |"
          end
        else
          if slot.class == Token
            print "| #{slot.token_model} |"
          else
            print "|   |"
          end
        end
      end
    end
  end

  class Token
    attr_reader :token_model
    def initialize(player_id)
      @token_owner = player_id
      @token_owner == "player1" ? @token_model = "X" : @token_model = "O"
    end 
  end

end

my_game = TicTacToe.new
puts "welcome to tictactoe"

5.times do
  puts "It's #{my_game.current_player.player_id}'s turn!"
  input = gets.chomp.to_i
  my_game.place_token(input - 1)
  my_game.gameboard.draw_board
  my_game.next_turn
end
