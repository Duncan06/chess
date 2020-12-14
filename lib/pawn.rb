class Pawn

    def self.get_moves(board, current_square, turn)

        possible_moves = []

        x = current_square[0]

        y = current_square[1]

        start_squares_white = [[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1]]

        start_squares_black = [[0, 6], [1, 6], [2, 6], [3, 6], [4, 6], [5, 6], [6, 6], [7, 6]]

        if turn % 2 == 0

            if start_squares_white.include? current_square

                if board[[x, y+2]].nil?

                    possible_moves << [x, y+2]

                end

            end

            if y + 1 < 7

                if board[[x, y+1]].nil?

                    possible_moves << [x, y+1]

                end

            end

            if board[[x+1, y+1]] != nil

                if board[[x+1, y+1]][0].match(/Black/)

                    possible_moves << [x+1, y+1]

                end

            end

            if board[[x-1, y+1]] != nil

                if board[[x-1, y+1]][0].match(/Black/)

                    possible_moves << [x-1, y+1]

                end

            end

        end

        if turn % 2 == 1

            if start_squares_black.include? current_square

                if board[[x, y-2]].nil?

                    possible_moves << [x, y-2]

                end

            end

            if y - 1 > 0

                if board[[x, y-1]].nil?

                    possible_moves << [x, y-1]

                end

            end

            if board[[x+1, y-1]] != nil

                if board[[x+1, y-1]][0].match(/White/)

                    possible_moves << [x+1, y-1]

                end

            end

            if board[[x-1, y-1]] != nil

                if board[[x-1, y-1]][0].match(/White/)

                    possible_moves << [x-1, y-1]

                end

            end

        end
        
        possible_moves

    end

end