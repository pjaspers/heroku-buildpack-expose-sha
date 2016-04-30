ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "minitest/pride"
require "hatchet"

class PackTest < Minitest::Test
  def test_deploy
    Hatchet::Runner.new("shacksample").deploy do |app|
      puts app.output
    end
  end
end
