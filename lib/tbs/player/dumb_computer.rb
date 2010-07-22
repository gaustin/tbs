module TBS
  module Player
    class DumbComputer < Base
      def message(string)
      end

      def draw(map)
      end

      def do_choose(choices)
        yield choices[0]
      end
    end
  end
end