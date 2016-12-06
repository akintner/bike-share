require 'bundler'
Bundler.require

require File.expand_path('../config/environment',  __FILE__)

use StationsApp
use CitiesApp
run BikeShareApp
