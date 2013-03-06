##
# Outpost::List

module Outpost
  module List
    extend ActiveSupport::Autoload

    DEFAULT_ORDER     = "id"
    DEFAULT_SORT_MODE = "desc"
    DEFAULT_PER_PAGE  = 25

    autoload :Base
    autoload :Column
    autoload :Filter
  end
end
