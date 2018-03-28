# frozen_string_literal: true

# We need to ensure OpenStruct and RecursiveOpenStruct classes exist to extend from
# Before the bundle is installed.
# Otherwise, the build fails when trying to read the version
require 'ostruct'

class RecursiveOpenStruct < OpenStruct
end

class DataStruct < RecursiveOpenStruct
  VERSION = '0.1.0'
end
