$:.unshift("/Library/RubyMotion/lib")

#if ENV['osx']
    require 'motion/project/template/osx'
#else
#    require 'motion/project/template/ios'
#end

require 'bundler'
require 'bubble-wrap'

Bundler.setup
Bundler.require

namespace :spec do
  task :lib do
    sh "bacon #{Dir.glob("spec/lib/**/*_spec.rb").join(' ')}"
  end

  task :motion => 'spec'

  task :all => [:lib, :motion]
end
