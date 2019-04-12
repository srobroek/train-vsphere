# frozen_string_literal: true


require 'vsphere-automation-sdk'
require 'vsphere-automation-cis'
require 'train'
require 'train/plugins'
require 'train-vsphere/platform'

module TrainPlugins
  module Vsphere
    class Connection < Train::Plugins::Transport::BaseConnection
      include TrainPlugins::Vsphere::Platform


      def initialize(options)
        @vcport = '443'
        @vchostname = options[:hostname]
        @username = options[:username]
        @password = options[:password]
        @vcuri = "#{@vchostname}:#{@vcport}"
        
        options[:insecure].casecmp?('false') ? (@vcsslverify = false) : (@vcsslverify = true)
        super(options)

      end



      def api_client
        @configuration = VSphereAutomation::Configuration.new.tap do |c|
          c.host = @vcuri
          c.username = @username
          c.password = @password
          c.scheme = 'https'
          c.verify_ssl = @vcsslverify
          c.verify_ssl_host = @vcsslverify
        end
        begin
          @api_client = VSphereAutomation::ApiClient.new(@configuration)
          @api_client.default_headers['Authorization'] = @configuration.basic_auth_token
          @session_api = VSphereAutomation::CIS::SessionApi.new(@api_client)
          @session_id = session_api.create('').value
          @api_client.default_headers['vmware-api-session-id'] = session_id  
        return @api_client
        rescue VSphereAutomation::ApiError => e
          puts "Exception when calling AccessConsolecliApi->get: #{e}"
        end
      end

      def uri
        "vsphere://#{@username}@#{@hostname}"
      end


      def local?
        false
      end

      # def uri
      #   'vsphere://'
      # end

    end
  end
end
