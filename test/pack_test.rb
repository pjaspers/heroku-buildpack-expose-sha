ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "minitest/pride"
require "hatchet"
require "pry"

def git_sha_of_shacksample
  git_dir = File.expand_path("../../repos/rack/shacksample/.git", __FILE__)
  `git --git-dir #{git_dir} log --pretty="%H"`.strip
end

class PackTest < Minitest::Test
  def test_it_can_find_the_sha_of_our_sample
    assert git_sha_of_shacksample.length > 0
  end

  def test_deploy
    Hatchet::Runner.new("shacksample").deploy do |app|
      app.run("bash") do |bash|
        bash.run("echo $SHA") { |result| assert_match git_sha_of_shacksample, result }
      end
    end
  end
end
