module TBS
  module Unit
    class Dinosaur < Base
      attr_reader :teeth
      def initialize(*args)
        super(*args)
        @actions << TBS::Action::Bite
        @teeth = 2
      end
    end

    class TRex < Base
      def initialize(*args)
        @teeth = 5
      end
    end

    class VRaptor < Dinosaur; end
  end
end
