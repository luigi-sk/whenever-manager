require 'Whenever'

module WheneverManager
  class Crontab < Whenever::CommandLine
    def list
      read_crontab
    end

    def whenever_cron
      super()
    end
  end
end