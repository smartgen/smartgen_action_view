require 'action_controller'
require 'action_view'

require 'smartgen'

require File.expand_path(File.join('smartgen_action_view/renderer'), File.dirname(__FILE__))
require File.expand_path(File.join('smartgen_action_view/pre_processor'), File.dirname(__FILE__))

Smartgen::Engine::Textile.register(Smartgen::Engine::ActionViewPreProcessor.new)
Smartgen::Engine::Markdown.register(Smartgen::Engine::ActionViewPreProcessor.new)
Smartgen::Engine::ERB.register(Smartgen::Engine::ActionViewPreProcessor.new)
