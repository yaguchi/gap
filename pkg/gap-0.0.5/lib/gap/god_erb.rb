require 'erb'
module Gap
  class GodErb
    def initialize(tmpl,app,part,commands)
      @app = app
      @part = part
      @commands = commands
      view = File.open(tmpl)
      @erb = ERB.new(view.read)
    end

    def render
      # ファイル出力
      output = "./config/god_#{@app}_#{@part}.rb"
      txt = @erb.result(binding)
      fw = File.open(output, 'w')
      fw.puts(txt)
      fw.close

      output
    end
  end
end
