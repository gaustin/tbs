module TBS
  module Game
    class Base
      attr_reader :players

      def initialize
        @maps = []
        @on_start = []
        @players = []

        @map_index = 0
        @player_index = 0
        @done = false
      end

      def map; @maps[@map_index]; end
      def player; @players[@player_index]; end
      def next_map; @map_index += 1; end
      def next_player; @player_index = (@player_index + 1) % @players.size; end
      def start_map; @on_start[@map_index].call(map) if @on_start[@map_index]; end

      def add_map(map, &on_start)
        @maps.push map
        @on_start.push on_start
      end

      def add_player(player)
        @players.push player
        player.game = self
      end

      def done
        players.each{|player| player.done }
        @done = true
      end

      def done?; @done; end

      def draw_all
        @players.each {|player| player.draw(map) }
      end

      def message_all(text)
        @players.each {|player| player.message(text) }
      end

      def run
        message_all("Welcome to #{name}!")
    
        while true
          break unless map

          start_map
          until done?
            turn(player())
            next_player()
          end      

          next_map
        end

        message_all("Thanks for playing.")
      end

      def turn
        raise NotImplementedError
      end

      def name
        raise NotImplementedError
      end
    end
  end
end