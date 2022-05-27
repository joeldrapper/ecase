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

    ensure_no_missing_cases
    ensure_no_excess_cases
  end

  def each(&block)
    @handled_cases.each(&block)
  end

  def [](candidate)
    @handled_cases.fetch(candidate) do
      types.find { |k, _v| candidate.is_a? k }&.last ||
        raise(Error, "No cases matching: #{candidate}.")
    end
  end

  protected

  def on(*conditions, &block)
    conditions.each do |condition|
      if @handled_cases.key?(condition)
        raise Error, "You already handled the case: #{condition}."
      else
        @handled_cases[condition] = block
      end
    end
  end

  private

  def types
    @handled_cases.lazy.select do |key, _value|
      key.is_a?(Class) || key.is_a?(Module)
    end
  end

  def ensure_no_missing_cases
    if missing_cases.any?
      raise Error, "You're missing case(s): #{missing_cases.join(', ')}."
    end
  end

  def ensure_no_excess_cases
    if excess_cases.any?
      raise Error, "You defined illegal case(s): #{excess_cases.join(', ')}."
    end
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
