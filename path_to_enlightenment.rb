# The path to Ruby Enlightenment starts with the following:

$LOAD_PATH << File.dirname(__FILE__)

require 'lib/about_asserts'
require 'lib/about_nil'
require 'lib/about_objects'
require 'lib/about_arrays'
require 'lib/about_array_assignment'
require 'lib/about_hashes'
require 'lib/about_strings'
require 'lib/about_symbols'
require 'lib/about_regular_expressions'
require 'lib/about_methods'
in_ruby_version("2") do
  require 'lib/about_keyword_arguments'
end
require 'lib/about_constants'
require 'lib/about_control_statements'
require 'lib/about_true_and_false'
require 'lib/about_triangle_project'
require 'lib/about_exceptions'
require 'lib/about_triangle_project_2'
require 'lib/about_iteration'
require 'lib/about_blocks'
require 'lib/about_sandwich_code'
require 'lib/about_scoring_project'
require 'lib/about_classes'
require 'lib/about_open_classes'
require 'lib/about_dice_project'
require 'lib/about_inheritance'
require 'lib/about_modules'
require 'lib/about_scope'
require 'lib/about_class_methods'
require 'lib/about_message_passing'
require 'lib/about_proxy_object_project'
require 'lib/about_to_str'
in_ruby_version("jruby") do
  require 'lib/about_java_interop'
end
require 'lib/about_extra_credit'
