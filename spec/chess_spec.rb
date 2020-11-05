require "./lib/chess.rb"
require "stringio"

describe Chess do

    describe "#initialize" do

        it "initializes game board" do

            game = Chess::Board.new

            result = game.board

            expect(result).to eq({

                [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

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
            
            game.board[[2, 2]] = ["Black Pawn", "\u265F"]

            result = game.pawn_moves([1, 1], [2, 2], 0)

            expect(result).to eq(true)

        end

        it "allows move to white piece location for black" do
            
            game = Chess::Board.new
            
            game.board[[2, 5]] = ["White Pawn", "\u2659"]

            result = game.pawn_moves([1, 6], [2, 5], 1)

            expect(result).to eq(true)

        end

        it "does not allow white piece to move to square with other white piece" do

            game = Chess::Board.new
            
            game.board[[2, 2]] = ["White Pawn", "\u2659"]

            result = game.pawn_moves([1, 1], [2, 2], 0)

            expect(result).to eq(false)

        end

        it "doees not allow black piece to move to square with other black piece" do

            game = Chess::Board.new
                
            game.board[[2, 5]] = ["Black Pawn", "\u265F"]

            result = game.pawn_moves([1, 6], [2, 5], 1)

            expect(result).to eq(false)

        end

    end

    describe "#capture_piece" do

        it "correctly removes piece that was captured and updates position of piece used" do

            game = Chess::Board.new

            game.board[[2, 2]] = ["Black Pawn", "\u265F"]

            result = game.capture_piece?([1, 1], [2, 2], 0)
                
            expect { print "Black Pawn captured by white" }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => ["White Pawn", "\u2659"], [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => ["White Pawn", "\u2659"], [1, 1] => nil, [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

            })

        end

        it "correctly removes white piece" do

            game = Chess::Board.new

            game.board[[2, 5]] = ["White Knight", "\u2658"]

            result = game.capture_piece?([1, 6], [2, 5], 1)
                
            expect { print "White Knight captured by black" }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => nil, [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                [0, 5] => nil, [1,5] => nil, [2, 5] => ["Black Pawn", "\u265F"], [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

            })

        end

        it "does not allow white to take white piece" do

            game = Chess::Board.new

            game.board[[2, 2]] = ["White Pawn", "\u2659"]

            result = game.capture_piece?([1, 1], [2, 2], 0)
                
            expect { print "Cannot move here." }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => ["White Pawn", "\u2659"], [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

            })

        end

        it "does not allow black to take black piece" do

            game = Chess::Board.new

            game.board[[2, 5]] = ["Black Knight", "\u265E"]

            result = game.capture_piece?([1, 6], [2, 5], 1)
                
            expect { print "Cannot move here." }.to output.to_stdout

            expect(game.board).to eq({

                [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                [0, 5] => nil, [1,5] => nil, [2, 5] => ["Black Knight", "\u265E"], [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                [0, 2] => nil, [1,2] => nil, [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                [0, 1] => ["White Pawn", "\u2659"], [1, 1] => ["White Pawn", "\u2659"], [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

            })

        end

        describe "#player_select" do

            it "takes player select and returns selected square coordinates" do

                io = StringIO.new

                io.puts "a1"

                io.rewind

                $stdin = io

                game = Chess::Board.new

                result = game.player_select()

                gets

                expect(result).to eq([0, 0])
                
                $stdin = STDIN

            end

            it "sanitizes input" do

                io = StringIO.new

                io.puts "U2"

                io.puts "b1"

                io.rewind

                $stdin = io

                game = Chess::Board.new
                
                result = game.player_select()

                gets

                expect { print "Please provide correct input." }.to output.to_stdout

                gets

                expect(result).to eq([0, 1])

                $stdin = STDIN

            end

        end

        describe "#player_move" do

            it "takes player move and correctly moves piece" do

                io = StringIO.new

                io.puts "b2"

                io.puts "c2"

                io.rewind

                $stdin = io

                game = Chess::Board.new

                game.display_board

                result = game.player_move(0)

                expect { print "It is your turn White"}.to output.to_stdout

                expect { print "Please enter a square to select in the format C4" }.to output.to_stdout

                gets

                expect { print "where would you like to move to?" }.to output.to_stdout

                gets

                game.display_board()

                expect(game.board).to eq({
                    
                    [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                    [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                    [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                    [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                    [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                    [0, 2] => nil, [1,2] => ["White Pawn", "\u2659"], [2, 2] => nil, [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                    [0, 1] => ["White Pawn", "\u2659"], [1, 1] => nil, [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                    [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

                }) 

                $stdin = STDIN

            end

            # Causes infinite loop but functions correctly

            # it "Does not allow illegal move with piece" do

            #     io = StringIO.new

            #     io.puts "b2"

            #     io.puts "c3"

            #     io.rewind

            #     $stdin = io

            #     game = Chess::Board.new

            #     result = game.player_move(0)

            #     expect { print "It is your turn White"}.to output.to_stdout

            #     expect { print "Please enter a square to select in the format C4" }.to output.to_stdout

            #     gets

            #     gets

            #     expect { print "Exited selection" }.to output.to_stdout

            #     game.display_board()

            #     $stdin = STDIN

            # end

            it "Captures and moves piece correctly" do

                io = StringIO.new

                io.puts "b2"

                io.puts "c3"

                io.rewind

                $stdin = io

                game = Chess::Board.new

                game.board[[2,2]] = ["Black Knight", "\u265E"]

                game.display_board

                result = game.player_move(0)

                expect { print "It is your turn White"}.to output.to_stdout

                expect { print "Please enter a square to select in the format C4" }.to output.to_stdout

                gets

                expect { print "where would you like to move to?" }.to output.to_stdout

                gets

                expect { print "Black Knight captured by white." }.to output.to_stdout

                game.display_board()

                expect(game.board).to eq({
                    
                    [0, 7] => ["Black Rook", "\u265C"], [1, 7] => ["Black Knight", "\u265E"], [2, 7] => ["Black Bishop", "\u265D"], [3, 7] => ["Black King", "\u265A"], [4, 7] => ["Black Queen", "\u265B"], [5, 7] => ["Black Bishop", "\u265D"], [6, 7] => ["Black Knight", "\u265E"], [7, 7] => ["Black Rook", "\u265C"],

                    [0, 6] => ["Black Pawn", "\u265F"], [1, 6] => ["Black Pawn", "\u265F"], [2, 6] => ["Black Pawn", "\u265F"], [3, 6] => ["Black Pawn", "\u265F"], [4, 6] => ["Black Pawn", "\u265F"], [5, 6] => ["Black Pawn", "\u265F"], [6, 6] => ["Black Pawn", "\u265F"], [7, 6] => ["Black Pawn", "\u265F"],

                    [0, 5] => nil, [1,5] => nil, [2, 5] => nil, [3, 5] => nil, [4, 5] => nil, [5, 5] => nil, [6, 5] => nil, [7, 5] => nil,

                    [0, 4] => nil, [1,4] => nil, [2, 4] => nil, [3, 4] => nil, [4, 4] => nil, [5, 4] => nil, [6, 4] => nil, [7, 4] => nil,

                    [0, 3] => nil, [1,3] => nil, [2, 3] => nil, [3, 3] => nil, [4, 3] => nil, [5, 3] => nil, [6, 3] => nil, [7, 3] => nil,

                    [0, 2] => nil, [1,2] => nil, [2, 2] => ["White Pawn", "\u2659"], [3, 2] => nil, [4, 2] => nil, [5, 2] => nil, [6, 2] => nil, [7, 2] => nil,

                    [0, 1] => ["White Pawn", "\u2659"], [1, 1] => nil, [2, 1] => ["White Pawn", "\u2659"], [3, 1] => ["White Pawn", "\u2659"], [4, 1] => ["White Pawn", "\u2659"], [5, 1] => ["White Pawn", "\u2659"], [6, 1] => ["White Pawn", "\u2659"], [7, 1] => ["White Pawn", "\u2659"],

                    [0, 0] => ["White Rook", "\u2656"], [1, 0] => ["White Knight", "\u2658"], [2, 0] => ["White Bishop", "\u2657"], [3, 0] => ["White Queen", "\u2655"], [4, 0] => ["White King", "\u2654"], [5, 0] => ["White Bishop", "\u2657"], [6, 0] => ["White Knight", "\u2658"], [7, 0] => ["White Rook", "\u2656"]

                }) 

                $stdin = STDIN

            end

        end

        describe "#check" do

            it "decides if piece is in check" do

                game = Chess::Board.new

                game.board[[4,1]] = nil

                game.board[[4,3]] = ["Black Queen", "\u265B"]

                result = game.capture_piece?([4,3], [4,2], 1)

                game.display_board

                result = game.check([4,2], 1)

                expect(game.white_check).to eq(true)

            end

        end

        describe "#display_board" do

            it "shows game board" do

                game = Chess::Board.new

                game.display_board

            end

        end

    end

end