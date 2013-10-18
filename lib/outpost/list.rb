##
# Outpost::List
module Outpost
  module List
    extend ActiveSupport::Autoload

    DEFAULT_ORDER_ATTRIBUTE   = "id"
    DEFAULT_ORDER_DIRECTION   = DESCENDING
    DEFAULT_PER_PAGE          = 25

    autoload :Base
    autoload :Column
    autoload :Filter
  end
end
