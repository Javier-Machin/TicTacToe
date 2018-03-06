class TicTacToe
  attr_reader :gameboard, :current_player

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @gameboard = Gameboard.new
    @current_player = @player1
  end

  def look_for_winner
    if gameboard.slots[0].class == Token && gameboard.slots[1].class == Token && gameboard.slots[2].class == Token
      if gameboard.slots[0].token_owner == gameboard.slots[1].token_owner &&  gameboard.slots[0].token_owner == gameboard.slots[2].token_owner
        print_winner(gameboard.slots[0].token_owner)
      end
    end  
    if gameboard.slots[3].class == Token && gameboard.slots[4].class == Token && gameboard.slots[5].class == Token
      if gameboard.slots[3].token_owner == gameboard.slots[4].token_owner &&  gameboard.slots[3].token_owner == gameboard.slots[5].token_owner
        print_winner(gameboard.slots[3].token_owner)
      end
    end
    if gameboard.slots[6].class == Token && gameboard.slots[7].class == Token && gameboard.slots[8].class == Token
      if gameboard.slots[6].token_owner == gameboard.slots[7].token_owner &&  gameboard.slots[6].token_owner == gameboard.slots[8].token_owner
        print_winner(gameboard.slots[6].token_owner)
      end
    end
    if gameboard.slots[0].class == Token && gameboard.slots[3].class == Token && gameboard.slots[6].class == Token
      if gameboard.slots[0].token_owner == gameboard.slots[3].token_owner &&  gameboard.slots[0].token_owner == gameboard.slots[6].token_owner
        print_winner(gameboard.slots[0].token_owner)
      end
    end
    if gameboard.slots[1].class == Token && gameboard.slots[4].class == Token && gameboard.slots[7].class == Token
      if gameboard.slots[1].token_owner == gameboard.slots[4].token_owner &&  gameboard.slots[1].token_owner == gameboard.slots[7].token_owner
        print_winner(gameboard.slots[1].token_owner)
      end
    end
    if gameboard.slots[2].class == Token && gameboard.slots[5].class == Token && gameboard.slots[8].class == Token
      if gameboard.slots[2].token_owner == gameboard.slots[5].token_owner &&  gameboard.slots[2].token_owner == gameboard.slots[8].token_owner
        print_winner(gameboard.slots[2].token_owner)
      end
    end
    if gameboard.slots[0].class == Token && gameboard.slots[4].class == Token && gameboard.slots[8].class == Token
      if gameboard.slots[0].token_owner == gameboard.slots[4].token_owner &&  gameboard.slots[0].token_owner == gameboard.slots[8].token_owner
        print_winner(gameboard.slots[0].token_owner)
      end
    end
    if gameboard.slots[2].class == Token && gameboard.slots[4].class == Token && gameboard.slots[6].class == Token
      if gameboard.slots[2].token_owner == gameboard.slots[4].token_owner &&  gameboard.slots[2].token_owner == gameboard.slots[6].token_owner
        print_winner(gameboard.slots[2].token_owner)
      end
    end            
  end

  def print_winner(winner)
    puts "#{winner} won!"
    gameboard.reset_board
  end

  def next_turn
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def place_token(location)
    gameboard.slots[location] = Token.new(current_player.player_id)
  end
  
  def input_validation(input)
    return "exit" if input.downcase == "exit"
    input = input.to_i
    while 1
      while !(input.between?(1,9))
        puts "Please, enter a number between 1 and 9"
        input = gets.chomp.to_i 
      end
      if gameboard.slots[input - 1].class == Token
        puts "Slot not empty, please enter a different one"
        input = gets.chomp.to_i
        next 
      end
      return input - 1
    end
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
        if index == 2 || index == 5 || index == 8   
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

    def reset_board
      @slots.map! { |slot| slot = "empty slot" }
    end  
  end

  class Token
    attr_reader :token_model, :token_owner
    def initialize(player_id)
      @token_owner = player_id
      @token_owner == "player1" ? @token_model = "X" : @token_model = "O"
    end 
  end

end

my_game = TicTacToe.new
puts "Welcome to TicTacToe!"
my_game.gameboard.draw_board

while 1 
  puts "It's #{my_game.current_player.player_id}'s turn!"
  puts "Enter slot number, being 1 the top left corner and 9 bottom right"
  puts "Enter exit to leave the game"
  input = gets.chomp
  input = my_game.input_validation(input) 
  break if input == "exit"
  my_game.place_token(input) 
  my_game.gameboard.draw_board
  my_game.look_for_winner
  my_game.next_turn
end

