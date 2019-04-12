# frozen_string_literal: true

basename = File.basename(__FILE__, ".rb")
libdir = File.expand_path("../#{basename}",__FILE__)
puts basename
puts libdir
#$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'train-vsphere/version'
require 'train-vsphere/transport'
require 'train-vsphere/platform'
require 'train-vsphere/connection'
