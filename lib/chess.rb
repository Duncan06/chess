require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'

module Chess

    class Board

        attr_accessor :board

        def initialize

            @board = {

                        [0,7] => "Black Rook", [1,7] => "Black Knight", [2,7] => "Black Bishop", [3,7] => "Black King", [4,7] => "Black Queen", [5,7] => "Black Bishop", [6,7] => "Black Knight", [7,7] => "Black Rook",

                        [0,6] => "Black Pawn", [1,6] => "Black Pawn", [2,6] => "Black Pawn", [3,6] => "Black Pawn", [4,6] => "Black Pawn", [5,6] => "Black Pawn", [6,6] => "Black Pawn", [7,6] => "Black Pawn",

                        [0,5] => nil, [1,5] => nil, [2,5] => nil, [3,5] => nil, [4,5] => nil, [5,5] => nil, [6,5] => nil, [7,5] => nil,

                        [0,4] => nil, [1,4] => nil, [2,4] => nil, [3,4] => nil, [4,4] => nil, [5,4] => nil, [6,4] => nil, [7,4] => nil,

                        [0,3] => nil, [1,3] => nil, [2,3] => nil, [3,3] => nil, [4,3] => nil, [5,3] => nil, [6,3] => nil, [7,3] => nil,

                        [0,2] => nil, [1,2] => nil, [2,2] => nil, [3,2] => nil, [4,2] => nil, [5,2] => nil, [6,2] => nil, [7,2] => nil,

                        [0,1] => "White Pawn", [1,1] => "White Pawn", [2,1] => "White Pawn", [3,1] => "White Pawn", [4,1] => "White Pawn", [5,1] => "White Pawn", [6,1] => "White Pawn", [7,1] => "White Pawn",

                        [0,0] => "White Rook", [1,0] => "White Knight", [2,0] => "White Bishop", [3,0] => "White Queen", [4,0] => "White King", [5,0] => "White Bishop", [6,0] => "White Knight", [7,0] => "White Rook",

                    }

        end

        def knight_moves(start, last)

            possible_moves = Knight.get_moves(self, start)

            possible_moves.include?(last) ? true : false

        end

        def bishop_moves(start, last)

            possible_moves = Bishop.get_moves(self, start)

            possible_moves.include?(last) ? true : false

        end

        def rook_moves(start, last)

            possible_moves = Rook.get_moves(self, start)

            possible_moves.include?(last) ? true : false

        end

        def queen_moves(start, last)

            possible_moves = Rook.get_moves(self, start)

            result = possible_moves.include?(last) ? true : false

            if result == false

                possible_moves = Bishop.get_moves(self, start)

                possible_moves.include?(last) ? true : false

            else

                result
            
            end

        end

        def king_moves(start, last)

            possible_moves = King.get_moves(self, start)

            possible_moves.include?(last) ? true : false

        end

        def pawn_moves(start, last)

            possible_moves = Pawn.get_moves(self, start, turn)

            possible_moves.include?(last) ? true : false

        end

    end

end