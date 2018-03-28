# frozen_string_literal: true

require 'recursive-open-struct'
require 'data_struct/version'
require 'yaml'

# We are going to use a custom OpenStruct object to hold the data
# This is based on RecursiveOpenStruct (which will recursively create OpenStruct object for all sub-elements)
# We are also adding methods to help sort and traverse this object, similar to a hash (.sort, .each, .first)
# Data can be accessed in any of the following forms
#  - DATA.atoms.buttons
#  - DATA[:atoms][:buttons]
#  - DATA['atoms']['buttons']
# DATA elements can be traversed using .each
#  - DATA.atoms.each { |key, value| ... }
# DATA elements can be sorted using .sort
#  - DATA.atoms.sort
#  - DATA.atoms.sort { |a, b| ... }
class DataStruct < RecursiveOpenStruct
  @path = nil

  # Override the default RecursiveOpenStuct initializer to recurse always recurse over arrays
  def initialize(hash = nil, args = {})
    @to_h = nil
    load(hash) && return if hash.is_a?(Pathname) || hash.is_a?(String)
    args[:recurse_over_arrays] = true
    super(hash, args)
  end

  def load(path)
    # Ensure path has a trailing slash
    @path = "#{path.chomp('/')}/"
    reload!
  end

  def reload!
    initialize
    return unless @path

    # Load DATA object using data/**/*.yml files
    Dir.glob(File.join(@path, '**', '*.yml')) do |path|
      relative_path = path.to_s.sub(@path, '').to_s
      cur_data = self
      relative_path.split('/').each do |file|
        path_part = file.chomp('.yml')
        cur_data = cur_data[path_part] ||= DataStruct.new
        next unless file.end_with?('.yml')
        yaml = YAML.load_file(path)
        yaml.each_pair { |key, value| cur_data[key] = value }
      end
    end

    self
  end

  # Add sort method to RecursiveOpenStruct
  def sort(&block)
    DataStruct.new(to_h.sort(&block).to_h)
  end

  # Add each methods to traverse over struct like a hash
  def each(&block)
    to_h.each(&block)
  end

  def each_value(&block)
    to_h.each_value(&block)
  end

  def each_child(&block)
    to_h.select { |_k, v| v.is_a?(RecursiveOpenStruct) }.each(&block)
  end

  def each_key(&block)
    to_h.each_key(&block)
  end

  def each_pair(&block)
    to_h.each_pair(&block)
  end

  def keys
    to_h.keys
  end

  def values
    to_h.values
  end

  # Add first method to get first item like a hash
  def first
    to_h.first
  end

  def to_h
    @to_h ||= super
  end

  # By default, RecursiveOpenStruct returns parameters (like recurse_over_arrays) in the to_h result
  # We want to reject anything that's not a RecursiveOpenStruct
  def children
    values.select { |v| v.is_a?(RecursiveOpenStruct) }
  end
end
