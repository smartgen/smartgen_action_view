# -*- encoding: utf-8 -*-
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rspec'
require 'smartgen'
require 'smartgen_action_view'

RSpec.configure do |config|
  def fixture(path)
    File.join(fixtures_dir, path)
  end
  
  def fixtures_dir
    File.expand_path('fixtures', File.dirname(__FILE__))
  end
  
  def expectation(path)
    File.read(fixture(File.join('expectations', path)))
  end
  
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
  
  alias silence capture
end
