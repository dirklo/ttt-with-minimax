class Board
    attr_accessor :cells

    def reset!
        @cells = Array.new(9, " ")
    end

    def initialize
        @cells = Array.new(9, " ")
    end

    def display
        puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
        puts "-----------"
        puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
        puts "-----------"
        puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
    end

    def position(input)
        cells[input.to_i - 1]
    end

    def full?
        cells.include?(" ") ? false : true
    end

    def turn_count
        cells.filter{|cell| cell != " "}.count 
    end
    
    def taken?(cell)
        cells[cell.to_i - 1] != " "
    end

    def valid_move?(input)
        !taken?(input) && input.match(/\d/) != nil
    end

    def update(cell, player)
        cells[cell.to_i - 1] = player.token
    end
end