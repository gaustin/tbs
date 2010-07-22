module TBS
  module Action
    class Attack < Base
      def damage_caused(unit); raise NotImplementedError; end
      def past_tense; raise NotImplementedError; end

      def call
        amount = damage_caused()
        game.message_all("#{unit.name} #{past_tense} #{target.name} for #{amount} damage.")
        target.hurt(amount)
      end
    end

    class Bite < Attack
      def damage_caused; @unit.teeth; end
      def past_tense; "bit"; end
    end

    class Shoot < Attack
      def self.range(unit); unit.range; end
      def damage_caused; @unit.caliber; end
      def past_tense; "shot"; end
    end

    class FirstAid < Base
      def self.target?(unit, other); unit.friend?(other); end
      def call
        target.hurt(-unit.heal)
        game.message_all("#{unit.name} healed #{target.name} for #{unit.heal} health.")
      end
    end 
  end
end