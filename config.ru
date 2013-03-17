require 'rubygems'
require 'bundler'
require 'yaml'
require 'faye'
require './app'

use ExpressYaSelf::App

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
run faye_server
