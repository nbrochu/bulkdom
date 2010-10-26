$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'resolv'
require 'whois'

require 'bulkdom/domain_list.rb'

module Bulkdom
  VERSION = "0.1.0"
end