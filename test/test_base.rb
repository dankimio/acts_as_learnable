require 'test_helper'

class BaseTest < MiniTest::Test
  def setup
    setup_db
    @card = Flashcard.create
  end

  def test_valid
    assert @card.valid?
    assert @card.due_today?
    assert_equal 2.5, @card.easiness_factor
    assert_equal 0, @card.repetitions
    assert_equal 0, @card.interval
    assert_nil @card.due
    assert_nil @card.studied_at
  end

  def test_incorrect_response
    @card.review(1)
    assert @card.due_today?
    assert_equal Date.today, @card.due
    assert_equal 0, @card.repetitions

    @card.review(2)
    assert @card.due_today?
    assert_equal Date.today, @card.due
    assert_equal 0, @card.repetitions
  end

  def test_correct_response
    # Recalled with serious difficulty
    @card.review(3)
    assert @card.due_today?
    assert_equal Date.today, @card.due
    assert_equal 0, @card.repetitions

    # Response after hesitation
    @card.review(4)
    refute @card.due_today?
    assert_equal Date.today + 1, @card.due
    assert_equal 1, @card.repetitions

    # Perfect response
    refute @card.due_today?
    @card.review(5)
    assert_equal Date.today + 6, @card.due
    assert_equal 2, @card.repetitions
  end

  def test_flow
    # Review two times
    @card.review(4)
    @card.review(4)

    assert_equal 2, @card.repetitions
    assert_equal 6, @card.interval
    assert_equal Date.today, @card.studied_at
    assert_equal Date.today + 6, @card.due
    assert_in_delta @card.easiness_factor, 2.5, 0.01
    refute @card.due_today?
  end

  def teardown
    teardown_db
  end
end
