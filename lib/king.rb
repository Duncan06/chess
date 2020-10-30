class King

    def self.get_moves(board, current_square)

        possible_moves = []

        x = current_square[0]

        y = current_square[1]

        if x + 1 < 7 

            possible_moves << [x+1, y]

        end

        if y + 1 < 7

            possible_moves << [x, y+1]

        end

        if x + 1 < 7 && y +1 < 7

            possible_moves << [x+1, y+1]

        end

        if x - 1 > 0

            possible_moves << [x-1, y]

        end

        if y - 1 > 0

            possible_moves << [x, y-1]

        end

        if x -1 > 0 && y - 1 > 0

            possible_moves << [x-1, y-1]

        end

        if x + 1 < 7 && y - 1 > 0

            possible_moves << [x+1, y-1]

        end

        if x - 1 > 0 && y + 1 < 7

            possible_moves << [x-1, y+1]

        end

        possible_moves

    end

end