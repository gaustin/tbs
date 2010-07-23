$:.unshift File.dirname(__FILE__)
require "tbs/matrix"
require "tbs/choice"
require "tbs/map"
require "tbs/action"
require "tbs/player"
require "tbs/unit"
require "tbs/game"

class Class
  def shortname
    name().gsub(/^.*:/, '')
  end
end

class NilClass
  def rep
    nil
  end
end