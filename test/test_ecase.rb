# frozen_string_literal: true
require "benchmark"
require "test_helper"

class TestEcase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ecase::VERSION
  end

  def test_conditions_returns_conditions
    example_ecase = Ecase.new [1, 2] do
      on(1) { "A" }
      on(2) { "B" }
    end

    assert_equal [1, 2], example_ecase.conditions
  end

  def test_blocks_returns_blocks
    example_ecase = Ecase.new [1, 2] do
      on(1) { "A" }
      on(2) { "B" }
    end

    assert_equal ["A", "B"], example_ecase.blocks.map(&:call)
  end

  def test_each_yields_condition_block_pairs
    example_ecase = Ecase.new [1, 2] do
      on(1) { "A" }
      on(2) { "B" }
    end

    assert_equal({
      1 => "A",
      2 => "B"
    }, example_ecase.to_h.transform_values(&:call))
  end

  def test_value_lookup
    result = ecase 1, [1, 2] do
      on(1) { "Hello" }
      on(2) { "World"}
    end

    assert_equal "Hello", result
  end

  def test_type_lookup
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

    assert_equal "You already handled the case: 2.", error.message
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
