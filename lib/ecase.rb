# frozen_string_literal: true
require "set"

require_relative "ecase/version"

class Ecase
  Error = Class.new(StandardError)

  include Enumerable

  def initialize(expected_cases, &block)
    @expected_cases = expected_cases.to_a
    @handled_cases = {}

    instance_exec(&block)

    freeze

    verify_exhaustiveness
    verify_no_excess_cases
  end

  def each(&block)
    @handled_cases.each(&block)
  end

  def [](candidate)
    return @handled_cases[candidate] if @handled_cases.key?(candidate)

    type = @handled_cases.keys.lazy
      .select { |k| k.is_a?(Class) || k.is_a?(Module) }
      .find { |k| candidate.is_a?(k) }

    return @handled_cases[type] if type

    raise Error, "No cases matching: #{candidate}."
  end

  protected

  def on(*values, &block)
    values.each do |value|
      raise Error, "You already defined the case: #{value}." if @handled_cases.key?(value)
      @handled_cases[value] = block
    end
  end

  private

  def verify_exhaustiveness
    raise Error, "You're missing case(s): #{missing_cases.join(', ')}." if missing_cases.any?
  end

  def verify_no_excess_cases
    raise Error, "You defined illegal case(s): #{excess_cases.join(', ')}." if excess_cases.any?
  end

  def missing_cases
    @expected_cases - @handled_cases.keys
  end

  def excess_cases
    @handled_cases.keys - @expected_cases
  end
end

def ecase(value, expected_cases, &block)
  Ecase.new(expected_cases, &block)[value].call
end
