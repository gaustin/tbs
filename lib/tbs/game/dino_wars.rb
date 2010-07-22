module TBS
  module Game
    class DinoWars < Base
      def name
        return "DinoWars: Westward Ho!"
      end

      def turn(player)
        player.new_turn

        draw_all()

        player.choose_all_or_done(player.unit_choices) do |choice|
          break if choice == DONE
          unit = choice.call

          draw_all()

          player.choose(unit.move_choices) do |move|
            move.call
          end

          draw_all()

          player.choose_or_done(unit.action_choices) do |choice|
            break if choice == DONE
            action = choice.call

            player.choose(action.generate(unit, self)) do |action_instance|
              action_instance.call 
            end
          end

          unit.done

          draw_all()
        end

        done() unless players().find_all{|player| player.units_left?}.size > 1
      end
    end
  end
end