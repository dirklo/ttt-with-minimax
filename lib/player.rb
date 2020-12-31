class Player
    attr_reader :token, :enemy_token

    def initialize(token)
        @token = token
        if token == "X"
            @enemy_token = "0"
        else 
            @enemy_token = "X"
        end    
    end
end