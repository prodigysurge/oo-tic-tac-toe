
#/// TO START GAME, INPUT bin/tictactoe IN THE TERMINAL \\\#
#/// INITIALIZING THE INSTANCE TO START A NEW GAME IS LOCATED IN bin/tictactoe \\\#

require 'pry'
# DECLARES THE CLASS OBJECT OF TICTACTOE.
class TicTacToe # HANDLES EVERYTHING THAT HAPPENS AND WHERE TO RETRIEVE FOR THE TICTACTOE GAME TO OPERATE PROPERLY
    
    # TELLS THE SOFTWARE WHAT COMBINATIONS OF INDEX LOCATIONS WILL RESULT 
    # IN A WIN. THERE ARE 8 SEPARATE POTENTIAL POSSIBILITIES.
    WIN_COMBINATIONS = [ # THIS IS A CLASS CONSTANT AND WILL/SHOULD NOT BE CHANGED
      [0, 1, 2], # TOP ROWd
      [3, 4, 5], # MIDDLE ROW
      [6, 7, 8], # BOTTOM ROW
      [0, 3, 6], # LEFT COLUMN
      [1, 4, 7], # MIDDLE COLUMN
      [2, 5, 8], # RIGHT COLUMN
      [0, 4, 8], # DIAGINAL TOP>BOTTOM, LEFT>RIGHT
      [6, 4, 2]  # DIAGINAL BOTTOM>TOP, LEFT>RIGHT
    ]

    # INITIALIZES A NEW ARRAY CONSISTING OF 9 EMPTY POSITIONS WHENEVER A NEW
    # GAME IS CREATED/STARTED "INITIALIZED"
    def initialize # GETS RUN EACH TIME THE INSTANT A NEW GAME IS INITIATED 
        @board = Array.new(9, " ") # EMPTY ARRAY STORES THE @BOARDS INDEX SPACES FOR THE GAME
        display_empty_board # DISPLAYS THE EMPTY BOARD WITH LOCATIONS THROUGH ITS METHOD
    end # END OF METHOD INITIALIZE

    def display_empty_board # EMPTY BOARD DISPLAY METHOD
        puts "" # EMPTY SPACE
        puts "" # EMPTY SPACE
        puts " 1 ""|"" 2 ""|"" 3 " # TOP ROW
        puts "-----------" # DIVIDER LINE
        puts " 4 ""|"" 5 ""|"" 6 " # MIDDLE ROW
        puts "-----------" # DIVIDER LINE
        puts " 7 ""|"" 8 ""|"" 9 " # BOTTOM ROW
    end # END OF METHOD DISPLAY_EMPTY_BOARD


  
    # METHOD THAT ACTUALLY DISPLAYS THE TICTACTOE BOARD ON THE COMMAND LINE
    # INTERFACE. METHOD ALSO IS WHERE THE INDEXES ARE LOCATED. SHOWS CURRENT
    # PLAYER SELECTED POSITIONS AFTER EACH PLAYER PLAY
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "         # THIS AND THE FOLLOWING LOC DISPLAYS PLAYERS INPUT ON BOARD IN CLI
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end # END OF METHOD DISPLAY_BOARD
  
    # METHOD TAKING THE INPUT OF THE PLAYER AND COVERTING THAT INPUT TO THE
    # CORRSPONDING INDEX NUMBER BY SUBTRACTING 1
    def input_to_index(user_input)
        user_input.to_i - 1 # TAKES THE USER INPUT AND SUBTRACTS 1 # TAKES ARG USER_INPUT/INTEGER AND CONVERTS TO INDEX THEN SUBTRACTS 1
    end # END OF METHOF INPUT_TO_INDEX
  
    # METHOD THAT DEFINES THAT THE INITIAL/DEFAULT PLAYER IS "X"
    def move(index, current_player = "X") # DEFAULT PLAY IS "X"
        @board[index] = current_player # REFERS TO CURRENT_PLAYER INDEX FOR DISPLAY
    end # ENDS METHOD MOVE
  
    # METHOD THAT DECIDES IF THE POSITION ON THE BOARD IS TAKEN OR NOT. THE
    # THE ? ENSURES THE ANSWER WILL BE EITHER TRUE OR FALSE. THE ! INDICATES THAT
    # THE METHOD MAY BE RETURNING UNEXPECTED RESULTS AND SHOULD NOT BE ALTERED
    def position_taken?(index)
        !(@board[index].nil? || @board[index] == " ") # IF POSITION IS NIL OR EMPTY, SPACE/POSITION IS AVAILABLE
    end # ENDS METHOD POSITION_TAKEN
  
    # METHOD DICTATING THAT THE ONLY VALID MOVES RESIDE IN INDEXES 1-8
    # METHOD ALSO ENSURING THAT THE POSITION REQUESTED BY THE PLAYER
    # IS INDEED AVAILABLE FOR CHOICE AND NOT ALREADY OCCUPIED BY THE 
    # OTHER PLAYER
    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index) # IF NUMBER IS BETWEEN 0 & 8 AND THE POSITION IS NOT TAKEN/EMPTY
    end # END OF METHOD VALID_MOVE?
  
    # METHOD THAT KEEPS TRACK OF HOW MANY TURNS THE PLAYERS AS A WHOLE HAVE
    # TAKEN BY ADDING ONE TO THE COUNTER EACH TIME A PLAYER ENTERS A VALID 
    # UNOCCUPIED POSITION FOR X/O PLACEMENT
    def turn_count
        turn = 0 # CREATES COUNTER
        @board.each do |index| # GOES THROUGH THE BOARD ONE BY ONE
            if index == "X" || index == "O" # WHAT IS BEING INPUT BY WHAT PLAYER "X" OR "O"
                turn += 1 # ADDS 1 TO THE COUNTER TO DETERMINE NEXT OR CURRENT PLAYER
            end
        end
        return turn # DISPLAYS THE TURN METHOD FOR CONTINUED PLAY OR GAME OVER
    end # END OF METHOD TURN_COUNT
  
    # METHOD KEEPING TRACK OF WHOS TURN IT IS TO PLAY. IF THE NUMBER IS AN 
    # AN EVEN NUMBER, THEN IT IS "O"'S TURN TO PLAY. IF THE NUMBER IS ODD
    # THEN NATURALLY IT WOULD BE THE "X"'S TURN TO PLAY'
    def current_player
        num_turns = turn_count # THESE TWO EQUATE EACHOTHER
        if num_turns % 2 == 0 # IS THE PLAY COUNTER AT AN EVEN BY DIVIDING THE NUM_TURNS BY 2
            player = "X" # IS PLAYER "X"'S TURN IF EVEN IS A RESULT OF ABOVE CODE
        else # OTHERWISE
            player = "O" # IT IS PLAYER "O"'S TURN AS IT WAS NOT TRUE IN LINE 95
        end
    return player # CALLS ON PLAYER METHOD 
    end # END OF METHOD CURRENT_PLAYER

    # REQUESTS THE PLAYER TO MAKE A SELECTION IN THE CLI FOR THEIR MOVE
    # BY DISPLAYING/PUTSING OUT THE STRING "PLEASE CHOOSE A NUMBER 1-9" ALSO CHECKS FOR
    # VALID SELECTION AND RETURNS THE UPDATED BOARD WITH THE PLAYERS PLAY
    def turn
        puts ""                                         # PUTS = DISPLAY OF STRING. THESE FEW LOC DISPLAYS / PUTS WHAT FOLLOWS UPON TURN BEING CALLED
        puts ""                                         # LOC 107-118
        puts "Please choose a number 1-9:"
        puts "" 
        puts "IF YOU DO NOT CHOOSE, THE MONKEY IN MY  
        CLI WILL COME OUT AND SMACK YOU IN THE FACE!"

        puts "     __     "
        puts '   /    \   '
        puts "  | O O  |  "
        puts '   \ L  /   '
        puts "    ----    "
        user_input = gets.chomp # GETS ASKS THE PLAYER FOR INPUT AND RETURNS THE INPUT AS A STRING. CHOMP REMOVES THE /N AT THE END OF STRING
        index = input_to_index(user_input) # COVERTS USER INPUT TO RELATIVE INDEX NUMBER
        if valid_move?(index) # IS IT  A VALID MOVE AT THAT INDEX, IS IT EMPTY?
            player_token = current_player # THESE TWO VARIABLES ARE THE SAME
            move(index, player_token) # MOVE ASKS FOR 2 ARGUMENTS, THE INDEX AND THE PLAYER_TOKEN, INDEX IS THE CONVERTED PLAYER INPUT
            display_board # DISPLAYS TH CURRENT BOARD AND AVAILABLE SPACES TO PLAYERS ON CLI AND TAKEN POSITIONS
        else
            turn # CALLS ON THE TURN METHOD
        end
    end # END OF METHOD TURN
  
    # METHOD THAT GOES THROUGH THE POTENTIAL WINNING COMBINATIONS LOOKING
    # FOR A WINNER OF THE GAME. IF NO WINNER THE FALSE IS RETURNED AND THE
    # GAME CONTINUES. IF WINNER, THEN THE SOFTWARE RETURNS THE WINNING COMBINATION
    def won?
        WIN_COMBINATIONS.each {|win_combo|
            index_0 = win_combo[0]                                              # SETTING UP AN EXAMPLE OF A WIN FOR THE NEXT SECTION
            index_1 = win_combo[1]
            index_2 = win_combo[2]
  
            position_1 = @board[index_0]
            position_2 = @board[index_1]
            position_3 = @board[index_2]
  
            if position_1 == "X" && position_2 == "X" && position_3 == "X"      # IF ALL THESE POSITIONS ARE "X"
                return win_combo                                                # THEN RETURN WINNING COMBINATION FOR "X"
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"   # OTHERWISE, IF "O"
                return win_combo                                                # SHOW WINNING COMBINATION FOR "O"
            end
        }
        return false # IF NO WINNING COMBINATION, RETURNS FALSE AND THE GAME CONTINUES
    end # ENDS METHOD WON?
  
    # METHOD THAT DEFINES WHEN THE BOARD IS COMPLETELY FULL AND NO MORE 
    # SELECTIONS CAN BE MADE. THE GAME IS OVER
    def full?
        @board.all? {|index| index == "X" || index == "O"} # THE THE ENTIRE BOARD IS FULL WITH EITHER "X" OR "O" THEN FULL
    end # ENDS METHOD FULL?
  
    # METHOD THAT DEFINES WHAT A DRAW WOULD LOOK LIKE. A BOARD THAT IS NOT WON
    # BUT THAT IS FULL. IF IT IS NOT WON OR FULL, RETURNS FALSE AND THE
    # THE GAME WILL CONTINUE
    def draw?
        if !won? && full? # IF NOT WON OR FULL
            return true # RETURN TRUE AND THE GAME IS OVER                                                         
        else # OTHERWISE
            return false # RETURN FALSE AND THE GAME CONTINUES ON
        end
    end # ENDS METHOD DRAW?
  
    # METHOD THE DECLARES WHEN THE GAME IS OVER. IF THE BOARD IS WON
    # OR IF THE GAME IS A DRAW. IF NEITHER WON OR DRAW, THEN THE
    # GAME WILL CONINUE
    def over?
        if won? || draw? # IF GAME HAS WON OR IS A DRAW
            return true # THE GAME IS OVER
        else # OTHERWISE
            return false # THE GAME CONTINUES ON
        end
    end # ENDS METHOD OVER?
  
    # METHOD THAT DECLARES A WINNER BY WAY OF USING THE INDEXES 
    # WHEN A WINNER IS DECLARED, THE METHOD EMPTIES THE ARRAY
    # BY USE OF THE INDEXES, IF WON THEN FALSE AND THE ARRAY WILL NOT EMPTY
    # IF TRUE, A WINNER HAS BEEN DECLARED OR A DRAW HAS OCCURED.
    def winner
        index = [] # CREATES AN EMPTY ARRAY FOR STORING
        index = won?    # DOES THE INDEX ARRAY EQUATE TO A WON? PLAYER?
            if index == false  # IF WON IS FALSE
                return nil # RETURNS NIL, ESSENTIALLY NOTHING> FALSE
            else # OTHER WISE
            if @board[index[0]] == "X" # IF "X" IS SELECTED
                return "X" # DISPLAY "X" IN THAT POSITION
            else # OTHERWISE
                return "O" # "O" IS DISPLAYED
            end
        end
    end # ENDS METHOD WINNER
  
    # METHOD THAT DEFINES THAT THE PLAY WILL CONTINUE UNTIL THE GAME IS
    # OVER. WHEN A WINNER IS DECLARED BY THE SOFTWARE, THE SOFTWARE PUTS 
    # OUT A STRING THAT CONTAINS "CONGRATULATIONS "X" OR "O". IF NO 
    # WINNER IS DECLARED, THEN THE GAME IS A DRAW AND THE SOFTWARE
    # PUTS OUT A STRING CONTAINING "CATS GAME!"
    def play
        turn until over? == true # TURN METHOD UNTIL OVER? METHOD IS TRUE
            if winner # IF THERE IS A WINNER
                puts "Congratulations #{winner}!" # DISPLAY/PUTS OUT STRING
            else # OTHERWISE
                puts "Cat's Game!" # DISPLAY/PUTS OUT STRING
            end
        end
    end # ENDS METHOD PLAY

