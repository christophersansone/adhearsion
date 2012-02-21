require 'thread'

class Object
  def synchronize(&block)
    @mutex ||= Mutex.new
    @mutex.synchronize &block
  end
end

class ThreadSafeArray
  include Enumerable

  def initialize
    @mutex = Mutex.new
    @array = []
  end

  def method_missing(method, *args, &block)
    @mutex.synchronize do
      @array.send method, *args, &block
    end
  end
end
