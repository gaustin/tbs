%w(base cli_player dumb_computer).each do |file|
  require File.join(File.dirname(__FILE__), "player", file)
end