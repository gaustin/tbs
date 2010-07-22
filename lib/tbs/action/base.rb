module TBS
  module Action
    class Base
      def self.rep
        ["Action", self.shortname]
      end

      def self.range(unit); 1; end
      def self.target?(unit, other); unit.enemy?(other); end

      # Default Action generator assumes action is something you
      # do to the enemy standing next to you. This behavior will
      # overriden in many subclasses.
      def self.generate(unit, game)
        map = game.map
        near = map.near_positions(range(unit), unit.x, unit.y)
        targets = near.find_all{|x, y| target?(unit, map.units[x, y]) }
        return targets.collect{|x, y| self.new(unit, game, x, y) }
      end

      attr_reader :unit, :game
      def initialize(unit, game, x, y)
        @unit = unit
        @game = game
        @x = x
        @y = y
      end

      def call
        raise NotImplementedError
      end

      def target
        game.map.units[@x, @y]
      end

      def rep
        [self.class.shortname, @x, @y]
      end
    end
  end
end