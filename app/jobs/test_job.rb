class TestJob < ApplicationJob
  def perform
    puts "test"
  end
end