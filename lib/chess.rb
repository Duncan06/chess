require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'

module Chess

    class Board

        attr_accessor :board, :spots, :black_king, :white_king, :black_check, :white_check

        def initialize

            @board = {

                        [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black Queen", "\u265B"], [4, 7] => ["Black King", "\u265A"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                        [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                        [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                        [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                        [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                        [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                        [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                        [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

                    }

            @spots = { 
                    
                        "a1" => [0, 0], "b1" => [1, 0], "c1" => [2, 0], "d1" => [3, 0], "e1" => [4, 0], "f1" => [5, 0], "g1" => [6, 0], "h1" => [7, 0],

                        "a2" => [0, 1], "b2" => [1, 1], "c2" => [2, 1], "d2" => [3, 1], "e2" => [4, 1], "f2" => [5, 1], "g2" => [6, 1], "h2" => [7, 1],

                        "a3" => [0, 2], "b3" => [1, 2], "c3" => [2, 2], "d3" => [3, 2], "e3" => [4, 2], "f3" => [5, 2], "g3" => [6, 2], "h3" => [7, 2],
                        
                        "a4" => [0, 3], "b4" => [1, 3], "c4" => [2, 3], "d4" => [3, 3], "e4" => [4, 3], "f4" => [5, 3], "g4" => [6, 3], "h4" => [7, 3],

                        "a5" => [0, 4], "b5" => [1, 4], "c5" => [2, 4], "d5" => [3, 4], "e5" => [4, 4], "f5" => [5, 4], "g5" => [6, 4], "h5" => [7, 4],

                        "a6" => [0, 5], "b6" => [1, 5], "c6" => [2, 5], "d6" => [3, 5], "e6" => [4, 5], "f6" => [5, 5], "g6" => [6, 5], "h6" => [7, 5],

                        "a7" => [0, 6], "b7" => [1, 6], "c7" => [2, 6], "d7" => [3, 6], "e7" => [4, 6], "f7" => [5, 6], "g7" => [6, 6], "h7" => [7, 6],

                        "a8" => [0, 7], "b8" => [1, 7], "c8" => [2, 7], "d8" => [3, 7], "e8" => [4, 7], "f8" => [5, 7], "g8" => [6, 7], "h8" => [7, 7]

                    }

            @black_king = [4, 7]

            @white_king = [4, 0]

            @black_check = false

            @white_check = false

            @black_checking_white = []

            @white_checking_black = []

            @white_king_moved = false

            @black_king_moved = false

            @white_left_rook_moved = false

            @white_right_rook_moved = false

            @black_left_rook_moved = false

            @black_right_rook_moved = false

            @white_pawn_end = [[0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7]]

            @black_pawn_end = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]

            @piece_selection = ["queen", "rook", "bishop", "knight"]

            @en_passe_white = []

            @en_passe_black = []

        end
        
        def knight_moves(start, last, turn, report=false, checking=false, board)

            possible_moves = Knight.get_moves(start)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def bishop_moves(start, last, turn, report=false, checking=false, board)

            possible_moves = Bishop.get_moves(start, board)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def rook_moves(start, last, turn, report=false, checking=false, board)

            possible_moves = Rook.get_moves(start, board)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            if valid == true

                if start == [0, 0]

                    @white_left_rook_moved = true

                elsif start == [7, 0]

                    @white_right_rook_moved = true

                elsif start == [0, 7] 

                    @black_right_rook_moved = true

                elsif start == [7, 7]

                    @black_left_rook_moved = true

                end

            end

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def queen_moves(start, last, turn, report=false, checking=false, board)

            valid = check_queen_move(start, last, report, board)

            if report

                return valid

            end

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def check_queen_move(start, last, report, board)

            possible_moves = Rook.get_moves(start, board)

            result = possible_moves.include?(last) ? true : false

            if result == true && report

                return possible_moves

            end

            if result == true && !report

                return true

            else

                possible_moves2 = Bishop.get_moves(start, board)

                valid = possible_moves2.include?(last) ? true : false
            
            end

            possible_moves << possible_moves2

            if report

                return possible_moves

            end

            valid

        end

        def king_moves(start, last, turn, report=false, checking=false, board)

            possible_moves = King.get_moves(start)

            if report

                return possible_moves

            end

            if start == [4, 0] && last == [6, 0] && board[[4, 0]] == ["White King", "\u2654"] && board[[7, 0]] == ["White Rook", "\u2656"]

                if @white_king_moved == false && @white_right_rook_moved == false

                    if board[[5, 0]] == nil  && board[[6, 0]] == nil

                        board[[5, 0]] = ["White Rook", "\u2656"]

                        board[[6, 0]] = ["White King", "\u2654"]

                        board[[4, 0]] = nil

                        board[[7, 0]] = nil

                        @white_king_moved = true

                        @white_right_rook_moved = true

                        return "castle"

                    end

                end

            elsif start == [4, 0] && last == [2, 0] 

                if @white_king_moved == false && @white_right_rook_moved == false && board[[4, 0]] == ["White King", "\u2654"] && board[[0, 0]] == ["White Rook", "\u2656"]

                    if board[[1, 0]] == nil  && board[[2, 0]] == nil && board[[3, 0]] == nil

                        board[[2, 0]] = ["White King", "\u2654"]
                        
                        board[[3, 0]] = ["White Rook", "\u2656"]

                        board[[4, 0]] = nil

                        board[[0, 0]] = nil

                        @white_king_moved = true

                        @white_left_rook_moved = true

                        return "castle"
                        
                    end

                end

            elsif start == [3, 7] && last == [1, 7]

                if @black_king_moved == false && @black_right_rook_moved == false && board[[3, 7]] == ["Black King", "\u265A"] && board[[0, 7]] == ["Black Rook", "\u265C"]

                    if board[[1, 7]] == nil  && board[[2, 7]] == nil

                        board[[1, 7]] = ["Black King", "\u265A"]

                        board[[2, 7]] = ["Black Rook", "\u265C"]

                        board[[0, 7]] = nil

                        board[[3, 7]] = nil

                        @black_king_moved = true

                        @black_right_rook_moved = true

                        return "castle"

                    end

                end

            elsif start == [3, 7] && last == [5, 7]

                if @black_king_moved == false && @black_left_rook_moved == false && board[[3, 7]] == ["Black King", "\u265A"] && board[[7, 7]] == ["Black Rook", "\u265C"]

                    if board[[4, 7]] == nil  && board[[5, 7]] == nil && board[[6, 7]] == nil

                        board[[4, 7]] = ["Black Rook", "\u265C"]
                        
                        board[[5, 7]] = ["Black King", "\u265A"]

                        board[[3, 7]] = nil

                        board[[7, 7]] = nil

                        @black_king_moved = true

                        @black_left_rook_moved = true

                        return "castle"

                    end

                end

            end

            valid = possible_moves.include?(last) ? true : false

            if valid

                if start == [4, 0]

                    @white_king_moved = true

                elsif start == [3, 7]

                    @black_king_moved = true

                end
            
            end

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def pawn_moves(start, last, turn, report=false, checking=false, board=@board)

            possible_moves = Pawn.get_moves(board, start, turn)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            if valid && turn % 2 == 0

                if [start[0], start[1]+2] == last

                    @en_passe_white << [start[0], start[1]+1]

                    @en_passe_white << @board[start]

                end

            end

            if valid && turn % 2 == 1

                if [start[0], start[1]-2] == last

                    @en_passe_black << [start[0], start[1]-1]

                    @en_passe_black << @board[start]

                end

            end

            if turn % 2 == 0

                if last == @en_passe_black[0]

                    puts "#{@en_passe_black[1][1]} #{@en_passe_black[1][0]} captured by white"

                    piece = board[start]

                    board[last] = piece

                    board[start] = nil

                    board[[last[0], last[1] - 1]] = nil

                    return "en passe"

                end

            end

            if turn % 2 == 1

                if last == @en_passe_white[0]

                    puts "#{@en_passe_white[1][1]} #{@en_passe_white[1][0]} captured by black"

                    piece = board[start]

                    board[last] = piece

                    board[start] = nil

                    board[[last[0], last[1] + 1]] = nil

                    return "en passe"

                end

            end

            if valid && turn % 2 == 0 && (@white_pawn_end.include? last) && @black_check == false

                if board[last] != nil

                    board_copy = @board.clone

                    king_check = recheck(@black_king, /Black/, turn % 2, board_copy)

                    if king_check && (@board[last] == ["Black King", "\u265A"] || @board[last] == ["Black King", "\u265A"])

                        @black_check = true

                        @white_checking_black << [start, last]

                        return

                    end

                    puts "#{board[last][1]} #{board[last][0]} captured by white"

                end

                piece = board[start]

                board[last] = piece

                board[start] = nil

                return "promotion"

            elsif valid && turn % 2 == 1 && (@black_pawn_end.include? last) && @white_check == false

                if board[last] != nil

                    board_copy = @board.clone

                    king_check = recheck(@white_king, /White/, turn % 2, board_copy)

                    if king_check && (@board[last] == ["White King", "\u2654"] || @board[last] == ["White King", "\u2654"])

                        @white_check = true

                        @black_checking_white << [start, last]

                        return

                    end

                    puts "#{board[last][1]} #{board[last][0]} captured by black"

                end

                piece = board[start]

                board[last] = piece

                board[start] = nil

                return "promotion"

            end

            check_capture_or_move(start, last, turn, valid, checking, board)

        end

        def play_game()

            game_over = false

            turn = 0

            until game_over

                display_board()
            
                game_over = player_move(turn)

                turn += 1

            end

        end

        def player_select()

            answer = (gets.chomp) rescue nil

            if answer == nil

                return false

            end

            answer = answer.downcase

            if @spots.has_key?(answer)
                
                @spots[answer]

            else

                puts "Please provide correct input."

                player_select()

            end

        end

        def player_response(current_player)

            puts "It is your turn #{current_player}"

            puts "Please enter a square to select in the format c4"

            start = player_select()

            if start == false

                puts "Exited selection"

                player_move(turn)

            end

            puts "where would you like to move to?"

            last = player_select()

            if last == false

                puts "Exited selection"

                player_move(turn)

            end

            return start, last

        end

        def player_move(turn)

            if @en_passe_white != [] && turn % 2 == 0

                @en_passe_white.shift

                @en_passe_white.shift

            end

            if @en_passe_black != [] && turn % 2 == 1

                @en_passe_black.shift

                @en_passe_black.shift

            end

            if @white_check == true

                possible = get_out_of_check(@white_king, /White/, turn % 2, @black_checking_white)

                if !possible

                    puts "Black wins! Checkmate."

                    return true

                else 

                    puts "White is in check."

                end

            elsif @black_check == true 

                possible = get_out_of_check(@black_king, /Black/, turn % 2, @white_checking_black)

                if !possible

                    puts "White wins! Checkmate."

                    return true

                else

                    puts "Black is in check."

                end

            end

            current_player = turn % 2

            current_player = (current_player == 0) ? "White" : "Black"

            if current_player == "White"

                king, color = @black_king, /White/

            else

                king, color = @white_king, /Black/

            end

            start, last = player_response(current_player)

            legal = check_move_type(start, last, turn)

            if legal == "castle"

                return

            end

            if legal == "promotion"

                pawn_promotion(last, turn)

                return

            end

            if legal == "en passe"

                return

            end

            if legal != false

                if current_player == "White" && @white_check == true

                    board_copy = @board.clone

                    capture_piece?(start, last, turn)

                    current = check(@white_king, /Black/, turn+1)

                    if !current

                        @white_check = false

                    end

                    if @white_check == true

                        while @white_check do

                            @black_check = false

                            puts "You must move yourself out of check"

                            @board = board_copy.clone

                            start, last = player_response(current_player)

                            legal = check_move_type(start, last, turn)

                            if legal != false

                                capture_piece?(start, last, turn)

                                current = check(@white_king, /Black/, turn)

                                if !current

                                    @white_check = false

                                end
                                            
                            else

                                puts "This piece cannot move there."

                                player_move(turn)

                            end

                        end

                    end

                elsif current_player == "Black" && @black_check == true

                    board_copy = @board.clone

                    capture_piece?(start, last, turn)

                    current = check(@black_king, /White/, turn)

                    if !current 

                        @black_check = false

                    end

                    if @black_check == true

                        while @black_check do

                            @white_check = false

                            puts "You must move yourself out of check"

                            @board = board_copy.clone

                            start, last = player_response(current_player)

                            legal = check_move_type(start, last, turn)

                            if legal != false

                                capture_piece?(start, last, turn)

                                current = check(@black_king, /White/, turn)

                                if !current 

                                    @black_check = false
            
                                end
                                            
                            else

                                puts "This piece cannot move there."

                                player_move(turn)

                            end

                        end

                    end

                else

                    board_copy = @board.clone

                    capture_piece?(start, last, turn)

                    check(@black_king, /White/, turn)

                    check(@white_king, /Black/, turn)

                    if (@black_check == true && current_player == "Black") || (@white_check == true && current_player == "White")

                        checked = true

                        if @black_check == true

                            @black_check = false

                        elsif @white_check == true 

                            @white_check = false

                        end

                    end

                    while checked

                        checked = player_self_check(start, last, turn, current_player, board_copy)

                    end

                end

            else

                puts "This piece cannot move there, or you have selected no piece, or the wrong color."

                player_move(turn)

            end

            return false

        end

        def check_move_type(start, last, turn, report=false, checking=false, board=@board)

            name = board[start][0] rescue nil

            if nil

                return false

            end

            case name

            when "White Knight" 

                knight_moves(start, last, turn, report, checking, board)

            when "Black Knight"

                knight_moves(start, last, turn, report, checking, board)

            when "White Bishop" 

                bishop_moves(start, last, turn, report, checking, board)

            when "Black Bishop"

                bishop_moves(start, last, turn, report, checking, board)

            when "White Rook" 

                rook_moves(start, last, turn, report, checking, board)

            when "Black Rook"

                rook_moves(start, last, turn, report, checking, board)

            when "White King" 

                king_moves(start, last, turn, report, checking, board)

            when "Black King"

                king_moves(start, last, turn, report, checking, board)

            when "White Queen" 

                queen_moves(start, last, turn, report, checking, board)

            when "Black Queen" 

                queen_moves(start, last, turn, report, checking, board)

            when "White Pawn" 

                pawn_moves(start, last, turn, report, checking, board)

            when "Black Pawn"

                pawn_moves(start, last, turn, report, checking, board)

            else

                false

            end
        
        end

        def capture_piece?(start, last, turn)

            if @board[last] != nil
                
                if turn % 2 == 0

                    if @board[start][0] == "White King"

                        @white_king = last

                    end

                    if @board[last][0].match(/Black/)

                        puts "#{@board[last][1]} #{@board[last][0]} captured by white"

                        piece = @board[start]

                        @board[last] = piece

                        @board[start] = nil

                    end

                else

                    if @board[last][0].match(/White/)

                        if @board[start][0] == "Black King"

                            @black_king = last

                        end

                        puts "#{@board[last][1]} #{@board[last][0]} captured by black"

                        piece = @board[start]

                        @board[last] = piece

                        @board[start] = nil

                    end

                end

            else

                if @board[start][0] == "White King"

                    @white_king = last

                elsif @board[start][0] == "Black King"

                    @black_king = last

                end

                piece = @board[start]

                @board[last] = piece

                @board[start] = nil

            end

        end

        def screen_capture_piece?(start, last, color, checking=false, board)

            if board[last] != nil
                
                if color == /White/

                    if board[last][0].match(/Black/) && !board[start][0].match(/Black/)

                        true

                    elsif board[last][0].match(/White/) && checking

                        true

                    else

                        false

                    end

                else

                    if board[last][0].match(/White/) && !board[start][0].match(/White/)

                        true

                    elsif board[last][0].match(/Black/) && checking

                        true

                    else

                        false

                    end

                end

            else

                if color == /White/ && board[start][0].match(/White/)

                    true

                elsif color == /Black/ && board[start][0].match(/Black/)

                    true

                else

                    false

                end

            end

        end

        def check_capture_or_move(start, last, turn, valid, checking=false, board)

            turn % 2 == 0 ? color = /White/ : color = /Black/

            if valid == true

                screen = screen_capture_piece?(start, last, color, checking, board)

                if screen

                    valid

                else

                    screen

                end

            else

                valid

            end

        end

        def check(king, color, turn)

            first = 0

            second = 0

            while first < 8

                while second < 8

                    if @board[[first, second]] != nil

                        if @board[[first, second]][0].match(color)

                            legal = check_move_type([first, second], king, (turn % 2), false, true)

                            if legal

                                if color == /Black/ && @black_check == false

                                    @white_check = true
                                    
                                    @black_checking_white << [first, second]

                                    return true

                                elsif color == /White/ && @white_check == false

                                    @black_check = true
                                    
                                    @white_checking_black << [first, second]

                                    return true

                                end

                            end

                        end

                    end

                    second += 1

                end

                first += 1

                second = 0

            end

            return false

        end

        def get_out_of_check(king, color, turn, checking)

            safe = []

            possible_moves = King.get_moves(king)

            possible_moves.each do |square| 
                
                if check(square, color, turn) == false

                    safe << square

                end

            end 

            king_moves_out = safe.nil?

            if !king_moves_out

                first = 0

                second = 0

                while first < 8

                    while second < 8

                        if @board[[first, second]] != nil

                            if @board[[first, second]][0].match(color)

                                checking.each do |square| 
                                    
                                    can_take = check_move_type([first, second], square, turn)

                                    if can_take

                                        copy = @board.clone

                                        piece = copy[[first, second]]

                                        copy[square] = piece

                                        color == /White/ ? color = /Black/ : color = /White/

                                        safety = recheck(king, color, turn, copy)

                                        if safety

                                            return true

                                        end

                                    end

                                end

                            end

                        end

                        second += 1

                    end

                    first += 1

                    second = 0

                end

                first = 0

                second = 0

                while first < 8

                    while second < 8

                        if @board[[first, second]] != nil

                            if @board[[first, second]][0].match(color)

                                checking.each do |square| 

                                    copy = @board.clone

                                    piece = copy[[first, second]]

                                    can_block = block_check(king, color, turn, copy)

                                    if can_block

                                        return true

                                    end

                                end

                            end

                        end

                        second += 1

                    end

                    first += 1

                    second = 0

                end

            end

            false

        end

        def recheck(king, color, turn, board)

            first = 0

            second = 0

            black_check = nil

            white_check = nil

            white_checking_black = []

            black_checking_white = []

            while first < 8

                while second < 8

                    if board[[first, second]] != nil

                        if board[[first, second]][0].match(color)

                            legal = check_move_type([first, second], king, turn, false, true, board)

                            if legal

                                turn % 2 == 0 ? white_check = true  : black_check = true

                                turn % 2 == 0 ? black_checking_white << [first, second]: white_checking_black << [first, second]

                            end

                        end

                    end
                    
                    second += 1

                end

                first += 1

                second = 0

            end

            if turn % 2 == 0

                white_check == nil ? true : false

            else

                black_check == nil ? true : false

            end

        end

        def block_check(king, color, turn, board)

            moves = []

            if color == /White/

                black_checks = @black_checking_white

                black_checks.each do |piece|

                    moves << check_move_type(piece, king, turn, true)

                rescue nil

                    if nil

                        return

                    end

                end

                eval_blocks(king, color, turn, board, moves)

            else

                white_checks = @white_checking_black

                white_checks.each do |piece|

                    moves << check_move_type(piece, king, turn, true)

                rescue nil

                    if nil

                        return

                    end

                end

                eval_blocks(king, color, turn, board, moves)

            end

        end

        def eval_blocks(king, color, turn, board, moves)

            scan = 0

            first = 0

            second = 0

            while first < 8

                while second < 8
                    
                    if board[[first, second]] != nil

                        if board[[first, second]][0].match(color)

                            current_piece_moves = check_move_type([first, second], king, turn, true)

                            if current_piece_moves == false

                                return

                            end

                            current_piece_moves.each do |block|

                                if board[[block]] == nil && board.dig([first, second], 0) != "White King" && board.dig([first, second], 0) != "Black King"

                                    boardcopy = board.clone

                                    boardcopy[block] = board[[first, second]]

                                    boardcopy[[first, second]] = nil

                                    opposite_color = nil

                                    color == /White/ ? opposite_color = /Black/ : opposite_color = /White/

                                    new_setup = (recheck(king, opposite_color, turn, boardcopy))

                                    if new_setup

                                        return true

                                    end

                                end

                                possible_block = moves[scan].include? block rescue nil

                                if possible_block == nil

                                    break

                                end

                            end

                        end

                    end

                    second += 1

                end

                first += 1

                second = 0

            end

            false

        end

        def player_self_check(start, last, turn, current_player, board_copy)

            puts "You can't put yourself in check."

            @board = board_copy.clone

            display_board

            start, last = player_response(current_player)

            legal = check_move_type(start, last, turn)

            if legal != false

                capture_piece?(start, last, turn)

                current = check(@black_king, /White/, turn)

                if !current 

                    current = check(@white_king, /Black/, turn)

                end

                if !current 

                    if @black_check == true

                        check(@black_king, /White/, turn)

                        @black_check = false

                        false

                    elsif @white_check == true

                        check(@white_king, /Black/, turn)

                        @white_check = false

                        false

                    else 

                        true

                    end

                else 

                    true
                    
                end
                            
            else

                puts "This piece cannot move there."

                player_move(turn)

            end

        end

        def pawn_promotion(last, turn)

            answer = promotion_response(last, turn)

            case answer

            when "queen"

                if turn % 2 == 0

                    @board[last] = ["White Queen", "\u2655"]

                else

                    @board[last] = ["Black Queen", "\u265B"]

                end

            when "rook"

                if turn % 2 == 0

                    @board[last] = ["White Rook", "\u2656"]

                else

                    @board[last] = ["Black Rook", "\u265C"]

                end

            when "knight"

                if turn % 2 == 0

                    @board[last] = ["White Knight", "\u2658"]

                else

                    @board[last] = ["Black Knight", "\u265E"]

                end

            when "bishop"

                if turn % 2 == 0

                    @board[last] = ["White Bishop", "\u2657"]

                else

                    @board[last] = ["Black Bishop", "\u265D"]

                end

            end

        end

        def promotion_response(last, turn)

            if turn % 2 == 0

                puts "What piece would you like to promote to white? You may choose Queen, Rook, Bishop, or Knight."

            else 

                puts "What piece would you like to promote to black? You may choose Queen, Rook, Bishop, or Knight." 

            end

            answer = (gets.chomp) rescue nil

            if answer == nil

                puts "You must enter a response"

                until answer != nil

                    puts "You may choose from Queen, Rook, Bishop, or Knight"

                    answer = gets.chomp

                end

            end

            answer = answer.downcase

            correct = false

            until correct

                if @piece_selection.include? answer

                    correct = true

                else

                    puts "Please provide correct input."

                    answer = gets.chomp

                    answer = answer.downcase

                end

            end

            return answer

        end

        def display_board()

            a1 = @board[[0, 0]].nil? ? " " : @board[[0, 0]][1].encode('utf-8')
            a2 = @board[[1, 0]].nil? ? " " : @board[[1, 0]][1].encode('utf-8')
            a3 = @board[[2, 0]].nil? ? " " : @board[[2, 0]][1].encode('utf-8')
            a4 = @board[[3, 0]].nil? ? " " : @board[[3, 0]][1].encode('utf-8')
            a5 = @board[[4, 0]].nil? ? " " : @board[[4, 0]][1].encode('utf-8')
            a6 = @board[[5, 0]].nil? ? " " : @board[[5, 0]][1].encode('utf-8')
            a7 = @board[[6, 0]].nil? ? " " : @board[[6, 0]][1].encode('utf-8')
            a8 = @board[[7, 0]].nil? ? " " : @board[[7, 0]][1].encode('utf-8')
            
            b1 = @board[[0, 1]].nil? ? " " : @board[[0, 1]][1].encode('utf-8')
            b2 = @board[[1, 1]].nil? ? " " : @board[[1, 1]][1].encode('utf-8')
            b3 = @board[[2, 1]].nil? ? " " : @board[[2, 1]][1].encode('utf-8')
            b4 = @board[[3, 1]].nil? ? " " : @board[[3, 1]][1].encode('utf-8')
            b5 = @board[[4, 1]].nil? ? " " : @board[[4, 1]][1].encode('utf-8')
            b6 = @board[[5, 1]].nil? ? " " : @board[[5, 1]][1].encode('utf-8')
            b7 = @board[[6, 1]].nil? ? " " : @board[[6, 1]][1].encode('utf-8')
            b8 = @board[[7, 1]].nil? ? " " : @board[[7, 1]][1].encode('utf-8')

            c1 = @board[[0, 2]].nil? ? " " : @board[[0, 2]][1].encode('utf-8')
            c2 = @board[[1, 2]].nil? ? " " : @board[[1, 2]][1].encode('utf-8')
            c3 = @board[[2, 2]].nil? ? " " : @board[[2, 2]][1].encode('utf-8')
            c4 = @board[[3, 2]].nil? ? " " : @board[[3, 2]][1].encode('utf-8')
            c5 = @board[[4, 2]].nil? ? " " : @board[[4, 2]][1].encode('utf-8')
            c6 = @board[[5, 2]].nil? ? " " : @board[[5, 2]][1].encode('utf-8')
            c7 = @board[[6, 2]].nil? ? " " : @board[[6, 2]][1].encode('utf-8')
            c8 = @board[[7, 2]].nil? ? " " : @board[[7, 2]][1].encode('utf-8')

            d1 = @board[[0, 3]].nil? ? " " : @board[[0, 3]][1].encode('utf-8')
            d2 = @board[[1, 3]].nil? ? " " : @board[[1, 3]][1].encode('utf-8')
            d3 = @board[[2, 3]].nil? ? " " : @board[[2, 3]][1].encode('utf-8')
            d4 = @board[[3, 3]].nil? ? " " : @board[[3, 3]][1].encode('utf-8')
            d5 = @board[[4, 3]].nil? ? " " : @board[[4, 3]][1].encode('utf-8')
            d6 = @board[[5, 3]].nil? ? " " : @board[[5, 3]][1].encode('utf-8')
            d7 = @board[[6, 3]].nil? ? " " : @board[[6, 3]][1].encode('utf-8')
            d8 = @board[[7, 3]].nil? ? " " : @board[[7, 3]][1].encode('utf-8')

            e1 = @board[[0, 4]].nil? ? " " : @board[[0, 4]][1].encode('utf-8')
            e2 = @board[[1, 4]].nil? ? " " : @board[[1, 4]][1].encode('utf-8')
            e3 = @board[[2, 4]].nil? ? " " : @board[[2, 4]][1].encode('utf-8')
            e4 = @board[[3, 4]].nil? ? " " : @board[[3, 4]][1].encode('utf-8')
            e5 = @board[[4, 4]].nil? ? " " : @board[[4, 4]][1].encode('utf-8')
            e6 = @board[[5, 4]].nil? ? " " : @board[[5, 4]][1].encode('utf-8')
            e7 = @board[[6, 4]].nil? ? " " : @board[[6, 4]][1].encode('utf-8')
            e8 = @board[[7, 4]].nil? ? " " : @board[[7, 4]][1].encode('utf-8')

            f1 = @board[[0, 5]].nil? ? " " : @board[[0, 5]][1].encode('utf-8')
            f2 = @board[[1, 5]].nil? ? " " : @board[[1, 5]][1].encode('utf-8')
            f3 = @board[[2, 5]].nil? ? " " : @board[[2, 5]][1].encode('utf-8')
            f4 = @board[[3, 5]].nil? ? " " : @board[[3, 5]][1].encode('utf-8')
            f5 = @board[[4, 5]].nil? ? " " : @board[[4, 5]][1].encode('utf-8')
            f6 = @board[[5, 5]].nil? ? " " : @board[[5, 5]][1].encode('utf-8')
            f7 = @board[[6, 5]].nil? ? " " : @board[[6, 5]][1].encode('utf-8')
            f8 = @board[[7, 5]].nil? ? " " : @board[[7, 5]][1].encode('utf-8')

            g1 = @board[[0, 6]].nil? ? " " : @board[[0, 6]][1].encode('utf-8')
            g2 = @board[[1, 6]].nil? ? " " : @board[[1, 6]][1].encode('utf-8')
            g3 = @board[[2, 6]].nil? ? " " : @board[[2, 6]][1].encode('utf-8')
            g4 = @board[[3, 6]].nil? ? " " : @board[[3, 6]][1].encode('utf-8')
            g5 = @board[[4, 6]].nil? ? " " : @board[[4, 6]][1].encode('utf-8')
            g6 = @board[[5, 6]].nil? ? " " : @board[[5, 6]][1].encode('utf-8')
            g7 = @board[[6, 6]].nil? ? " " : @board[[6, 6]][1].encode('utf-8')
            g8 = @board[[7, 6]].nil? ? " " : @board[[7, 6]][1].encode('utf-8')

            h1 = @board[[0, 7]].nil? ? " " : @board[[0, 7]][1].encode('utf-8')
            h2 = @board[[1, 7]].nil? ? " " : @board[[1, 7]][1].encode('utf-8')
            h3 = @board[[2, 7]].nil? ? " " : @board[[2, 7]][1].encode('utf-8')
            h4 = @board[[3, 7]].nil? ? " " : @board[[3, 7]][1].encode('utf-8')
            h5 = @board[[4, 7]].nil? ? " " : @board[[4, 7]][1].encode('utf-8')
            h6 = @board[[5, 7]].nil? ? " " : @board[[5, 7]][1].encode('utf-8')
            h7 = @board[[6, 7]].nil? ? " " : @board[[6, 7]][1].encode('utf-8')
            h8 = @board[[7, 7]].nil? ? " " : @board[[7, 7]][1].encode('utf-8')
            
            puts "
                 _________________________________
             8   | #{h1} | #{h2} | #{h3} | #{h4} | #{h5} | #{h6} | #{h7} | #{h8} |
                 _________________________________
             7   | #{g1} | #{g2} | #{g3} | #{g4} | #{g5} | #{g6} | #{g7} | #{g8} |
                 _________________________________
             6   | #{f1} | #{f2} | #{f3} | #{f4} | #{f5} | #{f6} | #{f7} | #{f8} |
                 _________________________________
             5   | #{e1} | #{e2} | #{e3} | #{e4} | #{e5} | #{e6} | #{e7} | #{e8} |
                 _________________________________
             4   | #{d1} | #{d2} | #{d3} | #{d4} | #{d5} | #{d6} | #{d7} | #{d8} |
                 _________________________________
             3   | #{c1} | #{c2} | #{c3} | #{c4} | #{c5} | #{c6} | #{c7} | #{c8} |
                 _________________________________
             2   | #{b1} | #{b2} | #{b3} | #{b4} | #{b5} | #{b6} | #{b7} | #{b8} |
                 _________________________________
             1   | #{a1} | #{a2} | #{a3} | #{a4} | #{a5} | #{a6} | #{a7} | #{a8} |
                 ---------------------------------

                   a   b   c   d   e   f   g   h
            
            "
        end

    end

end

game = Chess::Board.new

game.play_game
