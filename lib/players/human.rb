module Players
    class Human < Player
        def move(board)
            puts "Please select a cell:"
            gets.chomp
        end
    end
end