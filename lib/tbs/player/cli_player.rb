module TBS
  module Player
    class CLI < Base
      def message(string)
        puts string
      end

      def draw(map)
        puts "Terrain:"
        pp map.terrain.rep
        puts "Units:"
        pp map.units.rep
      end

      def do_choose(choices)
        mapping = rep_mapping(choices)

        choice = nil

        until choice
          puts "Choose: "
          puts mapping.keys

          print "Input: "
          choice_key = STDIN.gets.strip
          choice = mapping[choice_key]

          puts "Bad choice" unless choice
        end

        yield choice
      end

      def rep_mapping(data)
        mapping = {}
        data.each do |datum|
          mapping[datum.rep.inspect] = datum
        end
        return mapping
      end
    end
  end
end