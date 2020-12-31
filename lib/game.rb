class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 4, 8],
        [2, 4, 6],
        [0, 3, 6],
        [2, 5, 8],
        [1, 4, 7],
    ]

    @@this_game = nil

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
        @@this_game = self
    end

    def self.this_game
        @@this_game
    end

    def current_player
        board.turn_count.even? ? player_1 : player_2  
    end

    def enemy_player
        board.turn_count.even? ? player_2 : player_1 
    end

    def won?
        win = false
        i = board.cells
        WIN_COMBINATIONS.each do |c|
            if i[c[0]] == i[c[1]] && i[c[1]] == i[c[2]] && i[c[2]] != " "
                win = c
            end
        end
        win
    end

    def draw?
        board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        board.cells[won?[0]] if !draw? && over?
    end

    def turn
        while true
            puts "It is #{current_player.token}'s move!"
            current_move = current_player.move(board)
            if board.valid_move?(current_move)
                board.update(current_move, current_player)
                break
            else
                puts "invalid input, try again"
            end
        end
    end

    def play
        while !over?
            board.display
            turn
        end
        if draw?
            board.display
            puts "Cat's Game!"
            outcome = "draw"
        elsif won?
            board.display
            puts "Congratulations #{winner}!"
            outcome = "#{winner} wins"
        end
        outcome
    end




    # def minimax(board, is_maximizing)
    #     score = nil
    #     if is_maximizing
    #         # puts "maximizing path, checking board state: #{board.cells}"
    #         if self.won?
    #             # puts "maximizing path, game won, returning 1"
    #             score = 1
    #         elsif self.draw?
    #             # puts "maximizing path, draw, returning 0"
    #             score = 0
    #         else
    #             best_score = -5
    #             board.cells.each.with_index do |cell, i|
    #                 if !board.taken?("#{i + 1}")
    #                     board.cells[i] = self.current_player.token
    #                     result = minimax(board, false)
    #                     board.cells[i] = " "
    #                     if result > best_score
    #                         # puts "minimax result: #{result}, updating best score"
    #                         best_score = result
    #                     end
    #                 end
    #             end
    #             score = best_score
    #             # puts "minimax complete, returning #{score}"
    #         end
    #     else
    #         # puts "maximizing path, checking board state: #{board.cells}"
    #         if self.won?
    #             # puts "minimizing path, game won, returning 1"
    #             score = -1
    #         elsif self.draw?
    #             # puts "minimizing path, draw, returning 0"
    #             score = 0
    #         else
    #             best_score = 5
    #             board.cells.each.with_index do |cell, i|
    #                 if !board.taken?("#{i+1}")
    #                     board.cells[i] = self.enemy_player.token
    #                     result = minimax(board, true)
    #                     board.cells[i] = " "
    #                     if result < best_score
    #                         # puts "minimax result: #{result}, updating best score"
    #                         best_score = result
    #                     end
    #                 end
    #             end
    #             score = best_score
    #             # puts "minimax complete, returning #{score}"
    #         end
    #     end
    #     score
    # end
end
