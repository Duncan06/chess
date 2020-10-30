class Pawn

    def self.get_moves(board, current_square, turn)

        possible_moves = []

        x = current_square[0]

        y = current_square[1]

        if turn % 2 == 0

            if y + 1 < 7

                possible_moves << [x, y+1]

            end

            if board[x+1, y+1] != nil

                if board[x+1, y+1].match(/Black/)

                    possible_moves << [x+1, y+1]

                end

            end

            if board[x-1, y+1] != nil

                if board[x-1, y+1].match(/Black/)

                    possible_moves << [x-1, y+1]

                end

            end

        end

        if turn % 2 == 1

            if y - 1 > 0

                possible_moves << [x, y-1]

            end

            if board[x+1, y-1] != nil

                if board[x+1, y+1].match(/White/)

                    possible_moves << [x+1, y-1]

                end

            end

            if board[x-1, y-1] != nil

                if board[x-1, y-1].match(/White/)

                    possible_moves << [x-1, y-1]

                end

            end

        end

    end

end