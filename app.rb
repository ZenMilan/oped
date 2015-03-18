require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

# Require base
require 'sinatra/base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/json'

Dir['lib/**/*.rb'].sort.each { |file| require file }

require 'app/models'
require 'app/helpers'
require 'app/routes'

module Oped
  class App < Sinatra::Application
    configure do
      set :database, lambda {
        ENV['DATABASE_URL'] ||
          "postgres://localhost:5432/oped_#{environment}"
      }

      set :to_email, ENV['TO_EMAIL']
      set :from_email, ENV['FROM_EMAIL']
    end

    configure :development, :staging do
      database.loggers << Logger.new(STDOUT)
    end

    configure do
      disable :method_override
      disable :static
    end

    configure do
      Mail.defaults do
        delivery_method :file
      end
    end

    configure :production do
      Mail.defaults do
        delivery_method :smtp, {
          address:        ENV['MAILGUN_SMTP_SERVER'],
          port:           ENV['MAILGUN_SMTP_PORT'],
          user_name:      ENV['MAILGUN_SMTP_LOGIN'],
          password:       ENV['MAILGUN_SMTP_PASSWORD'],
          domain:         'oped.io',
          authentication: :plain
        }
      end
    end

    use Routes::Root
    use Routes::Posts

  end
end

include Oped::Models
