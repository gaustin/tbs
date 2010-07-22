module TBS
  module Player
    class Base
      attr_reader :name
      attr_accessor :game

      def initialize(name)
        @name  = name
        @units = []
      end

      def message(string); raise NotImplementedError; end
      def draw(map); raise NotImplementedError; end
      def do_choose; raise NotImplementedError; end

      def add_unit(unit); @units.push unit; end
      def clear_units; @units = []; end
      def units_left?; @units.any?{|unit| unit.alive? }; end
      def new_turn; @units.each{|unit| unit.new_turn }; end
      def done; @game.message_all("Level finished"); end

      def unit_choices 
        not_done = @units.find_all{|unit| unit.alive? && ! unit.done? }
        return not_done.map do |unit|
          Choice.new("Unit", unit.x, unit.y) { unit }
        end
      end

      def choose(choices, &block)
        do_choose(choices, &block) if choices?(choices)
      end

      def choices?(choices)
        ! (choices.empty? || (choices.size == 1 && choices[0] == DONE) )
      end

      def choose_all(choices, &block)
        while choices?(choices)
          choose(choices) do |choice|
            block.call(choice)
            choices.delete(choice)
          end
        end
      end

      def choose_all_or_done(choices, &block)
        choices_or_done = choices.dup
        choices_or_done.push DONE
        choose_all(choices_or_done, &block)
      end

      def choose_or_done(choices, &block)
        choices_or_done = choices.dup
        choices_or_done.push DONE
        choose(choices_or_done, &block)
      end
    end
  end
end