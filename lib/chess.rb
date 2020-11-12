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

                        [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                        [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                        [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                        [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                        [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                        [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                        [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                        [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

                    }

            @spots = { 
                    
                        "a1" => [0,0], "a2" => [1,0], "a3" => [2, 0], "a4" => [3, 0], "a5" => [4, 0], "a6" => [5, 0], "a7" => [6, 0],  "a8" => [7, 0],

                        "b1" => [0, 1], "b2" => [1, 1],  "b3" => [2, 1],  "b4" => [3, 1], "b5" => [4, 1], "b6" => [5, 1],  "b7" => [6, 1], "b8" => [7, 1],

                        "c1" => [0, 2], "c2" => [1, 2], "c3" => [2, 2], "c4" => [3, 2], "c5" => [4, 2], "c6" => [5, 2], "c7" => [6, 2],"c8" => [7, 2],
                        
                        "d1" => [0, 3], "d2" => [1, 3], "d3" => [2, 3], "d4" => [3, 3], "d5" => [4, 3], "d6" => [5, 3], "d7" => [6, 3], "d8" => [7, 3],

                        "e1" => [0, 4],  "e2" => [1, 4],  "e3" => [2, 4],  "e4" => [3, 4], "e5" => [4, 4], "e6" => [5, 4], "e7" => [6, 4], "e8" => [7, 4],

                        "f1" => [0, 5], "f2" => [1, 5],  "f3" => [2, 5], "f4" => [3, 5],  "f5" => [4, 5], "f6" => [5, 5], "f7" => [6, 5], "f8" => [7, 5],

                        "g1" => [0, 6], "g2" => [1, 6], "g3" => [2, 6],  "g4" => [3, 6], "g5" => [4, 6], "g6" => [5, 6], "g7" => [6, 6], "g8" => [7, 6],

                        "h1" => [0, 7], "h2" => [1, 7], "h3" => [2, 7], "h4" => [3, 7], "h5" => [4, 7], "h6" => [5, 7], "h7" => [6, 7], "h8" => [7, 7]

                    }

            @black_king = [3,7]

            @white_king = [4,0]

            @black_check = false

            @white_check = false

            @black_checking_white = []

            @white_checking_black = []

        end

        def knight_moves(start, last, turn, report=false)

            possible_moves = Knight.get_moves(start)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid)

        end

        def bishop_moves(start, last, turn, report=false)

            possible_moves = Bishop.get_moves(start, @board)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid)

        end

        def rook_moves(start, last, turn, report=false)

            possible_moves = Rook.get_moves(start, @board)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid)

        end

        def queen_moves(start, last, turn, report=false)

            valid = check_queen_move(start, last, report)

            if report

                return valid

            end

            check_capture_or_move(start, last, turn, valid)

        end

        def check_queen_move(start, last, report)

            possible_moves = Rook.get_moves(start, @board)

            result = possible_moves.include?(last) ? true : false

            if result == true && report

                return possible_moves

            end

            if result == true && !report

                return true

            else

                possible_moves2 = Bishop.get_moves(start, @board)

                valid = possible_moves2.include?(last) ? true : false
            
            end

            possible_moves << possible_moves2

            if report

                return possible_moves

            end

            valid

        end

        def king_moves(start, last, turn, report=false)

            possible_moves = King.get_moves(start)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid)

        end

        def pawn_moves(start, last, turn, report=false)

            possible_moves = Pawn.get_moves(@board, start, turn)

            if report

                return possible_moves

            end

            valid = possible_moves.include?(last) ? true : false

            check_capture_or_move(start, last, turn, valid)

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

        def player_move(turn)

            if @white_check == true

                possible = get_out_of_check(@white_king, /White/, turn % 2, @black_checking_white)

                if !possible

                    p "Black wins! Checkmate."

                else 

                    p "White is in check."

                end

            elsif @black_check == true 

                possible = get_out_of_check(@black_king, /Black/, turn % 2, @white_checking_black)

                if !possible

                    p "White wins! Checkmate."

                else

                    p "Black is in check."

                end

            end

            current_player = turn % 2

            current_player = (current_player == 0) ? "White" : "Black"

            if current_player == "White"

                king, color = @black_king, /White/

            else

                king, color = @white_king, /Black/

            end

            puts "It is your turn #{current_player}"

            puts "Please enter a square to select in the format C4"

            start = player_select()

            if start == false

                p "Exited selection"

                player_move(turn)

            end

            puts "where would you like to move to?"

            last = player_select()

            if last == false

                p "Exited selection"

                player_move(turn)

            end

            legal = check_move_type(start, last, turn)

            if legal != false

                if current_player == "White" && @white_check == true

                    board_copy = @board

                    capture_piece?(start, last, turn)

                    check(@white_king, /Black/, turn)

                elsif current_player == "Black" && @black_check == true

                    board_copy = @board

                    capture_piece?(start, last, turn)

                    check(@black_king, /White/, turn)

                else

                    capture_piece?(start, last, turn)

                    check(king, color, turn)

                end

            else

                "This piece cannot move there."

                player_move(turn)

            end

            turn += 1

        end

        def check_move_type(start, last, turn, report=false)

            name = @board[start][0]

            case name

            when "White Knight" 

                knight_moves(start, last, turn, report)

            when "Black Knight"

                knight_moves(start, last, turn, report)

            when "White Bishop" 

                bishop_moves(start, last, turn, report)

            when "Black Bishop"

                bishop_moves(start, last, turn, report)

            when "White Rook" 

                rook_moves(start, last, turn, report)

            when "Black Rook"

                rook_moves(start, last, turn, report)

            when "White King" 

                king_moves(start, last, turn, report)

            when "Black King"

                king_moves(start, last, turn, report)

            when "White Queen" 

                queen_moves(start, last, turn, report)

            when "Black Queen" 

                queen_moves(start, last, turn, report)

            when "White Pawn" 

                pawn_moves(start, last, turn, report)

            when "Black Pawn"

                pawn_moves(start, last, turn, report)

            else

                false

            end
        
        end

        def capture_piece?(start, last, turn)

            if @board[last] != nil
                
                if turn % 2 == 0

                    if start[0] == "White King"

                        @white_king = last

                    end

                    if @board[last][0].match(/Black/)

                        p "#{@board[last][1]} #{board[last][0]} captured by white"

                        piece = @board[start]

                        @board[last] = piece

                        @board[start] = nil

                    end

                else

                    if @board[last][0].match(/White/)

                        if start[0] == "Black King"

                            @black_king = last

                        end

                        p "#{@board[last][1]} #{board[last][0]} captured by black"

                        piece = @board[start]

                        @board[last] = piece

                        @board[start] = nil

                    end

                end

            else

                if start[0] == "White King" || "Black King"

                    start[0] == "White King" ? @white_king = last : @black_king = last

                end

                piece = @board[start]

                @board[last] = piece

                @board[start] = nil

            end

        end

        def screen_capture_piece?(start, last, turn)

            if @board[last] != nil
                
                if turn % 2 == 0

                    if @board[last][0].match(/Black/)

                        true

                    else

                        if !@white_check

                            p "Cannot move here."

                        end

                    end

                else

                    if @board[last][0].match(/White/)

                        true

                    else

                        if !@black_check

                            p "Cannot move here."

                        end

                    end

                end

            else

                true

            end

        end

        def check_capture_or_move(start, last, turn, valid)

            if valid == true

                screen_capture_piece?(start, last, turn)

                valid

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

                            legal = check_move_type([first, second], king, (turn % 2) + 1)

                            if legal

                                turn % 2 == 0 ? @white_check = true : @black_check = true

                                if turn % 2 == 0 

                                    if !@black_checking_white.include? [first, second]
                                    
                                        @black_checking_white << [first, second]

                                    end

                                else

                                    if !@white_checking_black.include? [first, second]
                                    
                                        @white_checking_black << [first, second]

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

        end

        def get_out_of_check(king, color, turn, checking)

            safe = []

            possible_moves = King.get_moves(king)

            possible_moves.each do |square| 
                
                if check(square, color, turn) == false

                    safe << square

                end

            end 

            king_moves_out = safe.include? true ? true : false

            if !king_moves_out

                first = 0

                second = 0

                while first < 8

                    while second < 8

                        if @board[[first, second]] != nil

                            if @board[[first, second]][0].match(color)

                                checking.each do |square| 
                                    
                                    can_take = check_move_type([first, second], square, turn)

                                    p "From get out of check #{can_take}, with this postion #{[[first, second]]} piece #{@board[[first, second]]}"

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

                                    copy[square] = piece

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

                            p "This is inside recheck "

                            legal = check_move_type([first, second], king, turn)

                            p "#{legal}, with this postion #{@board[[first, second]]}"

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

            if color == "White"

                white_checks = @white_checking_black

                white_checks.each do |piece|

                    moves << check_move_type(piece, king, turn, true)

                end

                p "moves after getting black checks #{moves}"

                eval_blocks(king, color, turn, board, moves)

            else

                black_checks = @black_checking_white

                black_checks.each do |piece|

                    moves << check_move_type(piece, king, turn, true)

                end

                p "moves after getting white checks #{moves}"

                eval_blocks(king, color, turn, board, moves)

            end

        end

        def eval_blocks(king, color, turn, board, moves)

            p "Enter eval_blocks"

            p "This is moves #{moves} from eval blocks"

            pieces_eval = moves.length

            scan = 0

            first = 0

            second = 0

            blocking_square = nil

            while first < 8

                while second < 8

                    if board[[first, second]] != nil

                        if board[[first, second]][0].match(color)

                            p "Get current piece moves"

                            current_piece_moves = check_move_type([first, second], king, turn, true)

                            current_piece_moves.each do |block|

                                p "This is current block #{block} and is #{board[block]}"

                                while scan <= pieces_eval

                                    if scan == pieces_eval

                                        p "scan == pieces_eval"

                                        p "This is value of board spot #{board[[blocking_square[0], blocking_square[1]]]} #{blocking_square[0]} #{blocking_square[1]}"

                                        p "This is value of board square #{board[[first, second]][0]}"

                                        if board[[blocking_square[0], blocking_square[1]]] == nil && board[[first, second]][0] != "White King" && board[[first, second]][0] != "Black King"

                                            boardcopy = board

                                            boardcopy[[blocking_square[0], blocking_square[1]]] = board[[first, second]]

                                            boardcopy[[first, second]] = nil

                                            opposite_color = nil

                                            color == /White/ ? opposite_color = /Black/ : opposite_color = /White/

                                            new_setup = (recheck(king, opposite_color, turn, boardcopy))

                                            if new_setup

                                                return true

                                            else

                                                break

                                            end

                                        else

                                            break

                                        end

                                    end

                                    possible_block = moves[scan].include? block rescue nil

                                    if possible_block == nil

                                        break

                                    end

                                    p "This is possible_block value #{possible_block}"

                                    if possible_block

                                        scan += 1

                                        blocking_square = block

                                    else

                                        break

                                    end

                                end

                            end
                            
                            scan = 0

                        end

                    end

                    second += 1

                end

                first += 1

                second = 0

            end

            false

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
                | #{h1} | #{h2} | #{h3} | #{h4} | #{h5} | #{h6} | #{h7} | #{h8} |
                _________________________________
                | #{g1} | #{g2} | #{g3} | #{g4} | #{g5} | #{g6} | #{g7} | #{g8} |
                _________________________________
                | #{f1} | #{f2} | #{f3} | #{f4} | #{f5} | #{f6} | #{f7} | #{f8} |
                _________________________________
                | #{e1} | #{e2} | #{e3} | #{e4} | #{e5} | #{e6} | #{e7} | #{e8} |
                _________________________________
                | #{d1} | #{d2} | #{d3} | #{d4} | #{d5} | #{d6} | #{d7} | #{d8} |
                _________________________________
                | #{c1} | #{c2} | #{c3} | #{c4} | #{c5} | #{c6} | #{c7} | #{c8} |
                _________________________________
                | #{b1} | #{b2} | #{b3} | #{b4} | #{b5} | #{b6} | #{b7} | #{b8} |
                _________________________________
                | #{a1} | #{a2} | #{a3} | #{a4} | #{a5} | #{a6} | #{a7} | #{a8} |
                ---------------------------------
            
            "
        end

    end

end