require_dependency "whenever_manager/application_controller"

module WheneverManager
  class DefinitionsController < ApplicationController

    def index
      @crontab = Crontab.new().list
      @schedule = Definition.schedule_read

      @definitions = Definition.order("created_at DESC")
      @definition = Definition.new()
    end
  
    def show
    end
  
    def edit
      @crontab = Crontab.new().list
      @schedule = Definition.schedule_read


    end
  
    def preview
    end
  
    def update
    end

    def new
      @crontab = Crontab.new().list
      @schedule = Definition.schedule_read

      @definition = Definition.new(content: @schedule, crontab_content: @crontab)
    end
  
    def create
      if params[:initialize_first]
        initialize_first
        redirect_to(definitions_path(), :notice => "Initialized")
      end
    end
  
    def delete
    end

    protected

    def initialize_first
      unless Definition.order("created_at DESC").any?
        @crontab = Crontab.new().list
        @schedule = Definition.schedule_read
        Definition.create(
            crontab_content: @crontab,
            content: @schedule
        )
      end
    end
  end
end
