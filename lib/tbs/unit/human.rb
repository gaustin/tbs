module TBS
  module Unit
    class Human < Base
      attr_reader :caliber
      attr_reader :range
      def initialize(*args)
        super(*args)
        @actions << TBS::Action::Shoot
        @caliber = 4
        @range = 3
      end
    end

    class Soldier < Human; end

    class Doctor < Human
      attr_reader :heal
      def initialize(*args)
        super(*args)
        @actions << TBS::Action::FirstAid
        @heal = 2
      end
    end
  end
end