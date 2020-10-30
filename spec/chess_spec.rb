require "./lib/chess.rb"
require "stringio"

describe Chess do

    describe "#initialize" do

        it "initializes game board" do

            game = Chess::Board.new

            result = game.board

            expect(result).to eq({

                [0,0] => "Black Rook", [0,1] => "Black Knight", [0,2] => "Black Bishop", [0,3] => "Black King", [0,4] => "Black Queen", [0,5] => "Black Bishop", [0,6] => "Black Knight", [0,7] => "Black Rook",

                [1,0] => "Black Pawn", [1,1] => "Black Pawn", [1,2] => "Black Pawn", [1,3] => "Black Pawn", [1,4] => "Black Pawn", [1,5] => "Black Pawn", [1,6] => "Black Pawn", [1,7] => "Black Pawn",

                [2,0] => nil, [2,1] => nil, [2,2] => nil, [2,3] => nil, [2,4] => nil, [2,5] => nil, [2,6] => nil, [2,7] => nil,

                [3,0] => nil, [3,1] => nil, [3,2] => nil, [3,3] => nil, [3,4] => nil, [3,5] => nil, [3,6] => nil, [3,7] => nil,

                [4,0] => nil, [4,1] => nil, [4,2] => nil, [4,3] => nil, [4,4] => nil, [4,5] => nil, [4,6] => nil, [4,7] => nil,

                [5,0] => nil, [5,1] => nil, [5,2] => nil, [5,3] => nil, [5,4] => nil, [5,5] => nil, [5,6] => nil, [5,7] => nil,

                [6,0] => "White Pawn", [6,1] => "White Pawn", [6,2] => "White Pawn", [6,3] => "White Pawn", [6,4] => "White Pawn", [6,5] => "White Pawn", [6,6] => "White Pawn", [6,7] => "White Pawn",

                [7,0] => "White Rook", [7,1] => "White Knight", [7,2] => "White Bishop", [7,3] => "White Queen", [7,4] => "White King", [7,5] => "White Bishop", [7,6] => "White Knight", [7,7] => "White Rook",

            })

        end

    end

    describe "#knight_moves" do

        it "decides if valid knight move from current location" do

            game = Chess::Board.new

            result = game.knight_moves([0,1], [2,2])

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.knight_moves([0,1], [3,3])

            expect(result).to eq(false)

        end

    end

    describe "#bishop_moves" do

        it "checks if move valid" do

            game = Chess::Board.new

            result = game.bishop_moves([0,2], [1,3])

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.bishop_moves([0,1], [3,3])

            expect(result).to eq(false)

        end

    end

    describe "#rook_moves" do 

        it "checks if move valid" do

            game = Chess::Board.new

            result = game.rook_moves([0,0], [1,0])

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.rook_moves([0,0], [2,3])

            expect(result).to eq(false)

        end

    end

    describe "#queen_moves" do 

        it "checks if move valid vertical" do

            game = Chess::Board.new

            result = game.queen_moves([0,0], [1,0])

            expect(result).to eq(true)

        end

        it "checks if move valid diagonal" do

            game = Chess::Board.new

            result = game.queen_moves([0,3], [2,5])

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.queen_moves([0,0], [2,3])

            expect(result).to eq(false)

        end

    end

end