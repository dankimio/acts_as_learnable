require 'active_record'
require 'acts_as_learnable/base'

module ActsAsLearnable
  # Extend ActiveRecord if defined
  ActiveRecord::Base.extend(ActsAsLearnable::Base) if defined?(ActiveRecord::Base)
end
