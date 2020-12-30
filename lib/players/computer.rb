require 'pry'
module Players
    class Computer < Player
    
        ##### MINIMAX ATTEMPT #####        
        def move(board)
            best_move = nil
            current_highest = -5
            board.cells.each.with_index do |cell, index|
                if !board.taken?("#{index + 1}")
                    board.cells[index] = Game.this_game.current_player.token
                    result = minimax(board, index, true)
                    board.cells[index] = " "
                    if result > current_highest
                        current_highest = result
                        best_move = index
                    end
                end
            end
            best_move = "#{best_move + 1}"
        end

        
        def minimax(board, index, is_maximizing)
            score = nil
            if is_maximizing
                if Game.this_game.won?
                    score = 1
                elsif Game.this_game.draw?
                    score = 0
                else
                    highest = -5
                    board.cells.each.with_index do |cell, i|
                        if !board.taken?("#{i + 1}")
                            board.cells[i] = Game.this_game.current_player.token
                            result = minimax(board, i, false)
                            board.cells[i] = " "
                            if result > highest
                                highest = result
                            end
                        end
                    end
                    score = highest
                end
            else
                if Game.this_game.won?
                    score = -1
                elsif Game.this_game.draw?
                    score = 0
                else
                    lowest = 5
                    board.cells.each.with_index do |cell, i|
                        if !board.taken?("#{i+1}")
                            board.cells[i] = Game.this_game.enemy_player.token
                            result = minimax(board, i, true)
                            board.cells[i] = " "
                            if result < lowest
                                lowest = result
                            end
                        end
                    end
                    score = lowest
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