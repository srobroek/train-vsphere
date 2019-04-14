# frozen_string_literal: true


require 'vsphere-automation-sdk'
require 'vsphere-automation-cis'
require 'train'
require 'train/plugins'
require 'train-vsphere/platform'
require 'vsphere-automation-appliance'
require 'vsphere-automation-content'
require 'vsphere-automation-vapi'
require 'vsphere-automation-vcenter'
require 'rbvmomi'

module TrainPlugins
  module Vsphere
    class Connection < Train::Plugins::Transport::BaseConnection
      include TrainPlugins::Vsphere::Platform


      def initialize(options)

        options = validate_options(options)
        super(options)
        enable_cache :api_call

      end

      def authenticate_api
        #Authenticates to the new open API using the vsphere automation SDK
        return api_client unless cache_enabled?(:api_call)

        @cache[:api_call][api_client.to_s.to_sym] ||= api_client
      end

      def authenticate_rest
        #Authenticates to the old API using rbvmomi
        return rest_client unless cache_enabled(:api_call)
        @cache[:api_call][api_client.to_s.to_sym] ||= rest_client
        




      def uri
        #Report vsphere URI
        "vsphere://#{options[:host]}"
      end


      def local?
        false
      end

    private

    def rest_client
      begin
        vim = RbVmomi::VIM.connect(host: options[:host], user: options[:user], password: options[:password], insecure: !options['insecure'])
        return vim
        rescue RbVmomi::
          fail Train::ClientError
          #puts "Exception when calling AccessConsolecliApi->get: #{e}"
      end
    end

    def api_client

    

      configuration = VSphereAutomation::Configuration.new.tap do |c|
        c.host = options[:host]
        c.username = options[:user]
        c.password = options[:password]
        c.scheme = 'https'
        c.verify_ssl = !options[:insecure]
        c.verify_ssl_host = !options[:insecure]
      end
      begin
        api_client = VSphereAutomation::ApiClient.new(configuration)
        api_client.default_headers['Authorization'] = configuration.basic_auth_token
        session_api = VSphereAutomation::CIS::SessionApi.new(api_client)
        session_id = session_api.create('').value
        api_client.default_headers['vmware-api-session-id'] = session_id  
        return api_client
      rescue VSphereAutomation::ApiError => e
        fail Train::ClientError
        #puts "Exception when calling AccessConsolecliApi->get: #{e}"
      end
    end

    def validate_options(options)
      if options[:user].nil?
        fail Train::ClientError,
            'A user needs to be set'
      end
      if options[:password].nil?
        fail Train::ClientError,
            'A password needs to be set'
      end
      if options[:host].nil?
        fail Train::ClientError,
            'A host needs to be set'
      end


      return options
    end

    end
  end
end
