def prompt_with_default(var, default)
  set(var) do
    Capistrano::CLI.ui.ask "#{var} [#{default}] : "
  end
  set var, default if eval("#{var.to_s}.empty?")
end

puts "Please select server to deploy to"
prompt_with_default(:server_name, "")
role(:app, server_name)

prompt_with_default(:user, "ubuntu")