module ForeverRails
  class RakeTasks < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load File.expand_path(f) }
    end
  end
end
