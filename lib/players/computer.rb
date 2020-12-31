require 'pry'
module Players
    class Computer < Player
    
        ##### MINIMAX ATTEMPT #####        
        def move(board)
            best_move_index = nil
            best_score = -Float::INFINITY
            board.cells.each.with_index do |cell, index|
                if !board.taken?("#{index + 1}")
                    board.cells[index] = self.token
                    score = minimax(board, false)
                    puts "board state: #{board.cells} is coming back as #{score}"
                    board.cells[index] = " "
                    if score > best_score
                        best_score = score
                        best_move_index = index
                    end
                end
            end
            best_move = "#{best_move_index + 1}"
            best_move
        end

        
        def minimax(board, is_maximizing)
            score = nil
            if Game.this_game.won? && Game.this_game.winner == self.token
                score = 1
            elsif Game.this_game.won? && Game.this_game.winner == self.enemy_token
                score = -1
            elsif Game.this_game.draw?
                score = 0
            else
                if is_maximizing
                    best_score = -Float::INFINITY
                    board.cells.each.with_index do |cell, i|
                        if !board.taken?("#{i + 1}")
                            board.cells[i] = self.token
                            result = minimax(board, false)
                            board.cells[i] = " "
                            if result > best_score
                                best_score = result
                            end
                        end
                    end
                    score = best_score
                else
                    best_score = Float::INFINITY
                    board.cells.each.with_index do |cell, i|
                        if !board.taken?("#{i + 1}")
                            board.cells[i] = self.enemy_token
                            result = minimax(board, true)
                            board.cells[i] = " "
                            if result < best_score
                                best_score = result
                            end
                        end
                    end
                    score = best_score
                end
            end
            score
        end
        
        
        
        
        ##### WORKING BRUTE FORCE SOLUTION #####
        #def move(board)
        #     if win_or_block(board) != nil
        #         win_or_block(board)
        #     elsif board.cells == Array.new(9, " ")
        #         "1"
        #     elsif !board.taken?("5")
        #         "5"
        #     else
        #         if board.cells[0] == board.cells[8] && board.cells[8] != " " || board.cells[2] == board.cells[6] && board.cells[6] != " "
        #             if !board.taken?("2") || !board.taken?("4") || !board.taken?("6") || !board.taken?("8")
        #                 ["2", "4", "6", "8"].sample
        #             else
        #                 ["1", "3", "7", "9"].sample
        #             end
        #         else
        #             if !board.taken?("1") || !board.taken?("3") || !board.taken?("7") || !board.taken?("9")
        #                 ["1", "3", "7", "9"].sample
        #             else
        #                 ["2", "4", "6", "8"].sample
        #             end
        #         end
        #     end
        # end
            
        # def win_or_block(board)
        #     b = board.cells
        #     move = nil
        #     Game::WIN_COMBINATIONS.each do |one, two, three|
        #         if b[one] == b[two] && b[two] != " " && b[three] == " "
        #             move = "#{three + 1}"
        #         elsif b[two] == b[three] && b[three] != " " && b[one] == " " 
        #             move = "#{one + 1}"
        #         elsif b[one] == b[three] && b[three] != " " && b[two] == " " 
        #             move = "#{two + 1}"
        #         end
        #     end
        #     move
        #end
    end
end