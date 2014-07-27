define :app_configure do
  deploy = params[:deploy_data]
  application = params[:app]
  run_action = params[:run_action] || :restart

  deploy = node[:deploy][application]

  if deploy[:deploy_to] && (node[:deploy][application]["initially_deployed"] || ::File.exist?(deploy[:deploy_to]))
    django_settings = ::File.join(deploy[:deploy_to], 'current', application, 'settings.py')
    template django_settings do
      source "settings.py.erb"
      owner deploy[:user]
      group deploy[:group]
      mode 0640
      variables Hash.new
      variables.update deploy
      variables.update :django_database => node[:deploy][application]["django_database"] || node["deploy_django"]["database"]
    end
  end
end

define :virtualenv_setup do
  deploy = params[:deploy_data]
  application = params[:app]

  deploy = node[:deploy][application]

  virtualenv_path = node[:virtualenv_path]
  requirements_file = ::File.join(deploy[:deploy_to], "current", "requirements.txt")
  Chef::Log.debug("ReqFile: " + requirements_file)
  if ::File.exists?(requirements_file)
    File.open(requirements_file) do | file_handle |
      file_handle.each_line do | line |
        package, ver = line.split("==")
        python_pip package do
          version ver if ver && ver.length > 0
          virtualenv virtualenv_path
          user deploy[:user]
          group deploy[:group]
          action :install
        end
      end
    end
  end
end
