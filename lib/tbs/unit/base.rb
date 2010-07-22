module TBS
  module Unit
    class Base
      attr_reader :player, :name, :health, :movement, :actions
      attr_accessor :x, :y
      def initialize(player, name)
        @player = player
        @name = name
        @health = 10
        @movement = 2
        @actions = []
      end

      def move(x, y)
        @player.game.map.move(@x, @y, x, y)
        @x = x
        @y = y
      end

      def hurt(damage)
        return if dead?
        @health -= damage
        die if dead?
      end

      def dead?
        return @health <= 0
      end

      def alive?
        return ! dead?
      end

      def die
        @player.game.message_all("#{name} died.")
      end

      def enemy?(other)
        (other != nil) && (player != other.player)
      end

      def friend?(other)
        (other != nil) && (player == other.player)
      end

      def done?; @done; end
      def done; @done = true; end
      def new_turn; @done = false; end

      def move_choices
        map = @player.game.map
        all = map.all_positions
        near = all.find_all {|x, y| map.within?(@movement, @x, @y, x, y) }
        valid = near.find_all {|x, y| map.units[x, y].nil? }
        return valid.collect do |x, y|
          Choice.new("Move", x, y) { self.move(x, y) }
        end
      end

      def action_choices
        return actions.collect do |action|
          Choice.new(*action.rep) { action }
        end
      end

      def rep
        [self.class.shortname, name]
      end
    end
  end
end