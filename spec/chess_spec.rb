require "./lib/chess.rb"
require "stringio"

describe Chess do

    describe "#initialize" do

        it "initializes game board" do

            game = Chess::Board.new

            result = game.board

            expect(result).to eq({

                [0, 7] => "Black Rook", [1, 7] => "Black Knight", [2, 7] => "Black Bishop", [3, 7] => "Black King", [4, 7] => "Black Queen", [5, 7] => "Black Bishop", [6, 7] => "Black Knight", [7, 7] => "Black Rook",

                [0, 6] => "Black Pawn", [1, 6] => "Black Pawn", [2, 6] => "Black Pawn", [3, 6] => "Black Pawn", [4, 6] => "Black Pawn", [5, 6] => "Black Pawn", [6, 6] => "Black Pawn", [7, 6] => "Black Pawn",

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => "White Pawn", [1, 1] => "White Pawn", [2, 1] => "White Pawn", [3, 1] => "White Pawn", [4, 1] => "White Pawn", [5, 1] => "White Pawn", [6, 1] => "White Pawn", [7, 1] => "White Pawn",

                [0, 0] => "White Rook", [1, 0] => "White Knight", [2, 0] => "White Bishop", [3, 0] => "White Queen", [4, 0] => "White King", [5, 0] => "White Bishop", [6, 0] => "White Knight", [7, 0] => "White Rook"

            })

        end

    end

    describe "#knight_moves" do

        it "decides if valid knight move from current location" do

            game = Chess::Board.new

            result = game.knight_moves([0, 1], [2, 2], 0)

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.knight_moves([0, 1], [3, 3], 0)

            expect(result).to eq(false)

        end

    end

    describe "#bishop_moves" do

        it "checks if move valid" do

            game = Chess::Board.new

            result = game.bishop_moves([0, 2], [1, 3], 0)

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.bishop_moves([0, 1], [3, 3], 0)

            expect(result).to eq(false)

        end

    end

    describe "#rook_moves" do 

        it "checks if move valid" do

            game = Chess::Board.new

            result = game.rook_moves([0, 0], [1, 0], 0)

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.rook_moves([0, 0], [2, 3], 0)

            expect(result).to eq(false)

        end

    end

    describe "#queen_moves" do 

        it "checks if move valid vertical" do

            game = Chess::Board.new

            result = game.queen_moves([0, 0], [1, 0], 0)

            expect(result).to eq(true)

        end

        it "checks if move valid diagonal" do

            game = Chess::Board.new

            result = game.queen_moves([0, 3], [2, 5], 0)

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.queen_moves([0, 0], [2, 3], 0)

            expect(result).to eq(false)

        end

    end

    describe "#king_moves" do 

        it "checks if move valid vertical" do

            game = Chess::Board.new

            result = game.king_moves([0, 4], [1, 4], 0)

            expect(result).to eq(true)

        end

        it "checks if move valid diagonal" do

            game = Chess::Board.new

            result = game.king_moves([0, 4], [1, 5], 0)

            expect(result).to eq(true)

        end

        it "identifies illegal move" do

            game = Chess::Board.new

            result = game.king_moves([0, 0], [2, 3], 0)

            expect(result).to eq(false)

        end

    end

    describe "#pawn_moves" do 

        it "moves white correctly" do

            game = Chess::Board.new

            result = game.pawn_moves([1, 1], [1, 2], 0)

            expect(result).to eq(true)

        end

        it "moves black correctly" do

            game = Chess::Board.new

            result = game.pawn_moves([1, 6], [1, 5], 1)

            expect(result).to eq(true)

        end

        it "allows move to black piece location for white" do
            
            game = Chess::Board.new
            
            game.board[[2, 2]] = "Black pawn"

            result = game.pawn_moves([1, 1], [2, 2], 0)

            expect(result).to eq(true)

        end

        it "allows move to white piece location for black" do
            
            game = Chess::Board.new
            
            game.board[[2, 5]] = "White pawn"

            result = game.pawn_moves([1, 6], [2, 5], 1)

            expect(result).to eq(true)

        end

        it "does not allow white piece to move to square with other white piece" do

            game = Chess::Board.new
            
            game.board[[2, 2]] = "White pawn"

            result = game.pawn_moves([1, 1], [2, 2], 0)

            expect(result).to eq(false)

        end

        it "doees not allow black piece to move to square with other black piece" do

            game = Chess::Board.new
                
            game.board[[2, 5]] = "Black pawn"

            result = game.pawn_moves([1, 6], [2, 5], 1)

            expect(result).to eq(false)

        end

    end

    describe "#capture_piece" do

        it "correctly removes piece that was captured and updates position of piece used" do

            game = Chess::Board.new

            game.board[[2, 2]] = "Black Pawn"

            result = game.capture_piece?([1, 1], [2, 2], 0)
                
            expect { print "Black Pawn captured by white" }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => "Black Rook", [1, 7] => "Black Knight", [2, 7] => "Black Bishop", [3, 7] => "Black King", [4, 7] => "Black Queen", [5, 7] => "Black Bishop", [6, 7] => "Black Knight", [7, 7] => "Black Rook",

                [0, 6] => "Black Pawn", [1, 6] => "Black Pawn", [2, 6] => "Black Pawn", [3, 6] => "Black Pawn", [4, 6] => "Black Pawn", [5, 6] => "Black Pawn", [6, 6] => "Black Pawn", [7, 6] => "Black Pawn",

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => "White Pawn", [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => "White Pawn", [1, 1] => nil, [2, 1] => "White Pawn", [3, 1] => "White Pawn", [4, 1] => "White Pawn", [5, 1] => "White Pawn", [6, 1] => "White Pawn", [7, 1] => "White Pawn",

                [0, 0] => "White Rook", [1, 0] => "White Knight", [2, 0] => "White Bishop", [3, 0] => "White Queen", [4, 0] => "White King", [5, 0] => "White Bishop", [6, 0] => "White Knight", [7, 0] => "White Rook",

            })

        end

        it "correctly removes white piece" do

            game = Chess::Board.new

            game.board[[2, 5]] = "White Knight"

            result = game.capture_piece?([1, 6], [2, 5], 1)
                
            expect { print "White Knight captured by black" }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => "Black Rook", [1, 7] => "Black Knight", [2, 7] => "Black Bishop", [3, 7] => "Black King", [4, 7] => "Black Queen", [5, 7] => "Black Bishop", [6, 7] => "Black Knight", [7, 7] => "Black Rook",

                [0, 6] => "Black Pawn", [1, 6] => nil, [2, 6] => "Black Pawn", [3, 6] => "Black Pawn", [4, 6] => "Black Pawn", [5, 6] => "Black Pawn", [6, 6] => "Black Pawn", [7, 6] => "Black Pawn",

                [0, 5] => nil, [1,5] => nil, [2, 5] => "Black Pawn", [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => "White Pawn", [1, 1] => "White Pawn", [2, 1] => "White Pawn", [3, 1] => "White Pawn", [4, 1] => "White Pawn", [5, 1] => "White Pawn", [6, 1] => "White Pawn", [7, 1] => "White Pawn",

                [0, 0] => "White Rook", [1, 0] => "White Knight", [2, 0] => "White Bishop", [3, 0] => "White Queen", [4, 0] => "White King", [5, 0] => "White Bishop", [6, 0] => "White Knight", [7, 0] => "White Rook",

            })

        end

        it "does not allow white to take white piece" do

            game = Chess::Board.new

            game.board[[2, 2]] = "White Pawn"

            result = game.capture_piece?([1, 1], [2, 2], 0)
                
            expect { print "Cannot move here." }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => "Black Rook", [1, 7] => "Black Knight", [2, 7] => "Black Bishop", [3, 7] => "Black King", [4, 7] => "Black Queen", [5, 7] => "Black Bishop", [6, 7] => "Black Knight", [7, 7] => "Black Rook",

                [0, 6] => "Black Pawn", [1, 6] => "Black Pawn", [2, 6] => "Black Pawn", [3, 6] => "Black Pawn", [4, 6] => "Black Pawn", [5, 6] => "Black Pawn", [6, 6] => "Black Pawn", [7, 6] => "Black Pawn",

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => "White Pawn", [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => "White Pawn", [1, 1] => "White Pawn", [2, 1] => "White Pawn", [3, 1] => "White Pawn", [4, 1] => "White Pawn", [5, 1] => "White Pawn", [6, 1] => "White Pawn", [7, 1] => "White Pawn",

                [0, 0] => "White Rook", [1, 0] => "White Knight", [2, 0] => "White Bishop", [3, 0] => "White Queen", [4, 0] => "White King", [5, 0] => "White Bishop", [6, 0] => "White Knight", [7, 0] => "White Rook",

            })

        end

        it "does not allow black to take black piece" do

            game = Chess::Board.new

            game.board[[2, 5]] = "Black Knight"

            result = game.capture_piece?([1, 6], [2, 5], 1)
                
            expect { print "Cannot move here." }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => "Black Rook", [1, 7] => "Black Knight", [2, 7] => "Black Bishop", [3, 7] => "Black King", [4, 7] => "Black Queen", [5, 7] => "Black Bishop", [6, 7] => "Black Knight", [7, 7] => "Black Rook",

                [0, 6] => "Black Pawn", [1, 6] => "Black Pawn", [2, 6] => "Black Pawn", [3, 6] => "Black Pawn", [4, 6] => "Black Pawn", [5, 6] => "Black Pawn", [6, 6] => "Black Pawn", [7, 6] => "Black Pawn",

                [0, 5] => nil, [1,5] => nil, [2, 5] => "Black Knight", [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => "White Pawn", [1, 1] => "White Pawn", [2, 1] => "White Pawn", [3, 1] => "White Pawn", [4, 1] => "White Pawn", [5, 1] => "White Pawn", [6, 1] => "White Pawn", [7, 1] => "White Pawn",

                [0, 0] => "White Rook", [1, 0] => "White Knight", [2, 0] => "White Bishop", [3, 0] => "White Queen", [4, 0] => "White King", [5, 0] => "White Bishop", [6, 0] => "White Knight", [7, 0] => "White Rook",

            })

        end

    end

end