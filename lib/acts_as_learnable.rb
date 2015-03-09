require 'active_record'
require 'acts_as_learnable/base'
require 'byebug'

module ActsAsLearnable
  # Extend ActiveRecord if defined
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.extend(ActsAsLearnable::Base)
  end
end
