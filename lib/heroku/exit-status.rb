require "readline"
require "heroku/command/base"
require "heroku/client/rendezvous"

class Heroku::Command::Run < Heroku::Command::Base
  protected
  def run_attached(command)
    command_with_exit = %Q{#{command}; echo heroku-command-exit-status $?}

    app_name = app
    opts = { :attach => true, :ps_env => get_terminal_environment }
    opts[:size] = options[:size] if options[:size]

    process_data = action("Running `#{command}` attached to terminal", :success => "up") do
      process_data = api.post_ps(app_name, command_with_exit, opts).body
      status(process_data["process"])
      process_data
    end
    rendezvous_session(process_data["rendezvous_url"])
  end
end
class Heroku::Client::Rendezvous
  private
  def fixup(data)
    return nil if ! data
    if data.respond_to?(:force_encoding)
      data.force_encoding('utf-8') if data.respond_to?(:force_encoding)
    end
    if running_on_windows?
      begin
        data.gsub!(/\e\[[\d;]+m/, '')
      rescue # ignore failed gsub, for instance when non-utf8
      end
    end
    if data =~ /\Aheroku-command-exit-status ([\d]+)/
      exit $1.to_i
    end
    output.isatty ? data : data.gsub(/\cM/,"")
  end
end
