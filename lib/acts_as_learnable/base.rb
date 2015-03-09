module ActsAsLearnable
  module Base
    def acts_as_learnable
      class_eval do
        include ActsAsLearnable::InstanceMethods
      end
    end
  end

  module ClassMethods
    def acts_as_learnable?
      true
    end
  end

  module InstanceMethods
    def review(recall_quality)
      fail unless (1..5).include?(recall_quality)

      # If the quality of response was lower than 3, then start repetitions from the beginning
      reset and return if recall_quality <= 2

      # Calculate new easiness factor
      update_easiness_factor(recall_quality)

      # Repeat all items that scored below 4
      if recall_quality == 3
        self.interval = 0
      else
        # Otherwise, increment repetitions count and set new interval
        self.repetitions += 1
        update_interval
      end

      schedule_repetition
      save
    end

    def due_today?
      due.nil? || due <= Date.today
    end

    private

    # Bad recall quality, start over
    def reset
      self.repetitions = 0
      self.interval = 0
      self.due = Date.today
      self.studied_at = Date.today
      save
    end

    # Calculates and updates easiness factor
    def update_easiness_factor(quality)
      new_easiness_factor = calculate_easiness_factor(quality)
      # If EF is less than 1.3 then let EF be 1.3
      self.easiness_factor = new_easiness_factor < 1.3 ? 1.3 : new_easiness_factor
    end

    # Calculates new easiness factor according to the formula
    def calculate_easiness_factor(quality)
      easiness_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    end

    # Update interval according to the formula
    def update_interval
      # TODO: Extract magic numbers
      self.interval =
        case repetitions
        when 1 then 1
        when 2 then 6
        else
          interval(repetitions - 1) * easiness_factor
        end
    end

    # Update next repetition date, set studied_at to today
    def schedule_repetition
      self.due = Date.today + interval
      self.studied_at = Date.today
    end
  end
end
