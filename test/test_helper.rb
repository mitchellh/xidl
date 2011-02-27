require "test/unit/assertions"
require "protest"
require "xidl"

class Protest::TestCase
  include Test::Unit::Assertions
end

Protest.report_with(:progress)
