%w(base attack).each do |file|
  require File.join(File.dirname(__FILE__), "action", file)
end