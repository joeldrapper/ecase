# frozen_string_literal: true
require "benchmark"
require "test_helper"

class TestEcase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ecase::VERSION
  end

  def test_value_comparison
    result = ecase 1, [1, 2] do
      on(1) { "Hello" }
      on(2) { "World"}
    end

    assert_equal "Hello", result
  end

  def test_type_comparison
    result = ecase 1, [String, Integer] do
      on(String) { "Hello" }
      on(Integer) { "World" }
    end

    assert_equal "World", result
  end

  def test_catches_excess_cases
    error = assert_raises(Ecase::Error) do
      ecase 1, [1, 2] do
        on(1) { "a" }
        on(2) { "b" }
        on(3) { "c" }
      end
    end

    assert_equal "You defined illegal case(s): 3.", error.message
  end

  def test_catches_missing_cases
    error = assert_raises(Ecase::Error) do
      ecase 1, [1, 2] do
        on(1) { "a" }
      end
    end

    assert_equal "You're missing case(s): 2.", error.message
  end

  def test_catches_duplicate_cases
    error = assert_raises(Ecase::Error) do
      ecase 1, [1, 2] do
        on(1) { "a" }
        on(2) { "b" }
        on(2) { "c" }
      end
    end

    assert_equal "You already defined the case: 2.", error.message
  end

  def test_catches_invalid_lookup
    error = assert_raises(Ecase::Error) do
      ecase 3, [1, 2] do
        on(1) { "a" }
        on(2) { "b" }
      end
    end

    assert_equal "No cases matching: 3.", error.message
  end
end
