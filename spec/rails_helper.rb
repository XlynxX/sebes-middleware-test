ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("Rails running in production!") if Rails.env.production?

require 'rspec/rails'
require 'webmock/rspec'

# блокируем все реальные HTTP кроме локальных
WebMock.disable_net_connect!(allow_localhost: true)

# Проверяем миграции
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
