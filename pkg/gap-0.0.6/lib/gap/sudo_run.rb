module Gap 
  module SudoRun
    def sudo_run command
      run command.gsub(/sudo/,sudo)
    end 
  end 
end
