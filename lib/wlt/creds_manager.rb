require 'fileutils'

module Wlt

  class CredsManager
    attr_accessor :username, :password

    def initialize(username=nil, password=nil)
      @username = username
      @password = password
    end

    def save
      validate

      wlt_dir = File.join(Dir.home, '.wlt')
      FileUtils.mkdir_p(wlt_dir)
      File.open(File.join(wlt_dir, 'credentials'), 'w+') do |file|
        file.write("WATSON_USERNAME=#{@username}\n")
        file.write("WATSON_PASSWORD=#{@password}\n")
      end
    end

    def load
      File.open(File.join(Dir.home, '.wlt', 'credentials')) do |file|
        file.each_line do |line|
          username = line.match(/WATSON_USERNAME=(.*)/)
          @username = username[1] if username
          password = line.match(/WATSON_PASSWORD=(.*)/)
          @password = password[1] if password
        end
      end
    end

    private

    def invalid_argument(name)
      "'#{name}' cannot be empty. See: https://console.bluemix.net/docs/services/watson/getting-started-credentials.html#getting-credentials-manually"
    end

    def validate
      raise CredsManagerError, 'Missing username' if @username.nil? || @username.empty?
      raise CredsManagerError, 'Missing password' if @password.nil? || @password.empty?
    end
  end
end
