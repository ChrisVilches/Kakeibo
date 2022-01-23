module Logging
  @loggers = {}

  def logger
    @logger ||= Logging.logger_for(self.class.name)
  end

  class << self
    def logger_for(classname)
      @loggers[classname] ||= create_logger_for(classname)
    end

    private

    def create_logger_for(classname)
      Logger.new(out_file, 'daily', progname: classname)
    end

    def out_file
      return File::NULL if Rails.env.test?

      "#{Rails.root}/log/job.#{Rails.env}.log"
    end
  end
end
