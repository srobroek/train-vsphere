# frozen_string_literal: true

class IllegalStateError < StandardError
  def initialize(msg = nil)
    super
  end
end

class NoServicesFoundError < IllegalStateError
  def initialize(origin, name)
    super("Expected one service '#{origin}/#{name}', but found none.")
  end
end

class MultipleServicesFoundError < IllegalStateError
  def initialize(origin, name)
    super("Expected one service '#{origin}/#{name}', but found multiple.")
  end
end
