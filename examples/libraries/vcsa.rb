class Vcsa < Inspec.resource(1)
  name 'vcsa'
	supports platform: 'vsphere'
	desc 'Use the vsphere audit resource to get information from the vSphere API'

  def initialize
    begin
      @auth_token = inspec.backend.authenticate
    rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
    end
  end

  def ssh
    begin
     return VSphereAutomation::Appliance::AccessConsolecliApi.new(@auth_token).get.value
        
    rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
    end
  end

  def exists?
    return true
  end

  def authenticate


  end
end