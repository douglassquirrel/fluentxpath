require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/fluentxpath'

Hoe.plugin :newgem

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'fluentxpath' do
  self.developer 'Douglas Squirrel', 'ds@douglassquirrel.com'
  self.rubyforge_name       = self.name 
end

require 'newgem/tasks'
