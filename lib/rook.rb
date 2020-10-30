class Rook

    def self.get_moves(board, current_square)

        possible_moves = []

        x = current_square[0]

        y = current_square[1]

        while x < 7 

            x += 1

            possible_moves << [x, y]

        end

        x = current_square[0]

        while y < 7 

            y += 1

            possible_moves << [x, y]

        end

        y = current_square[1]

        while x > 0 

            x -= 1

            possible_moves << [x, y]

        end

        x = current_square[0]

        while y > 0

            y -= 1

            possible_moves << [x, y]

        end

        possible_moves

    end

end