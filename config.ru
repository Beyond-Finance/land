# frozen_string_literal: true

require "rubygems"
require "bundler"

Bundler.require :default, :development

Combustion.initialize! :active_record,
  database_reset: false,
  load_schema: false
  
run Combustion::Application
