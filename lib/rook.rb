class Rook

    def self.get_moves(current_square, board)

        possible_moves = []

        x = current_square[0]

        y = current_square[1]

        while x < 7 

            x += 1

            if board[[x, y]] == nil

                possible_moves << [x, y]

            else

                possible_moves << [x, y]

                break

            end

        end

        x = current_square[0]

        while y < 7 

            y += 1

            if board[[x, y]] == nil

                possible_moves << [x, y]

            else

                possible_moves << [x, y]

                break

            end

        end

        y = current_square[1]

        while x > 0 

            x -= 1

            if board[[x, y]] == nil

                possible_moves << [x, y]

            else

                possible_moves << [x, y]

                break

            end

        end

        x = current_square[0]

        while y > 0

            y -= 1

            if board[[x, y]] == nil

                possible_moves << [x, y]

            else

                possible_moves << [x, y]

                break

            end

        end

        possible_moves

    end

end