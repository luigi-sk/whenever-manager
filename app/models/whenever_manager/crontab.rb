require 'fileutils'
require 'tempfile'
require 'Whenever'

module WheneverManager
  class Crontab < Whenever::CommandLine
    attr_accessor :result

    # Do nothing, prevent before exit program
    def exit(param)
      @result = param
    end

    # make public
    def read_crontab
      super()
    end

  end
end