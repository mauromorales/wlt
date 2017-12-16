require 'wlt/version'
require 'wlt/creds_manager'
require 'wlt/translator'

module Wlt; end

class Error < RuntimeError; end
class CredsManagerError < Error; end
