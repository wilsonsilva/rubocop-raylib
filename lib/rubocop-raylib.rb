# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/raylib'
require_relative 'rubocop/raylib/version'
require_relative 'rubocop/raylib/inject'

RuboCop::Raylib::Inject.defaults!

require_relative 'rubocop/cop/raylib_cops'
