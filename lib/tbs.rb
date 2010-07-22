%w(matrix choice map action player unit game).each do |file|
  require File.join(File.dirname(__FILE__), "tbs", file)
end

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