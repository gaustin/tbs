%w(base dino_wars).each do |file|
  require File.join(File.dirname(__FILE__), "game", file)
end