# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "rails/all"
require "actual_db_schema"
require "minitest/autorun"
require "debug"

Rails.env = "test"

class FakeApplication < Rails::Application
  def initialize
    super
    config.root = File.join(__dir__, "dummy_app")
  end
end

Rails.application = FakeApplication.new

db_config = {
  adapter: "sqlite3",
  database: "tmp/test.sqlite3"
}
ActiveRecord::Tasks::DatabaseTasks.database_configuration = { test: db_config }
ActiveRecord::Base.establish_connection(**db_config)

ActualDbSchema.config[:enabled] = true
