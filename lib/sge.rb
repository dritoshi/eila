class SGE
  def initialize(options, std_file, err_file, sh_file)
    @options  = options
    @std_file = std_file
    @err_file = err_file
    @sh_file  = sh_file
  end
  attr_reader :command

  def prepare(my_command)
    # @command = [@options, @std_file, @err_file].join(" ")
    # @command << "\n\n" + my_command + "\n"

    @command =  @options + "\n"
    @command << '#$ -o ' + @std_file + "\n"
    @command << '#$ -e ' + @err_file + "\n\n"
    @command << my_command + "\n\n"

    sh_io = File.open(@sh_file, "w")
    sh_io.puts @command
    sh_io.close
  end

  def submit(queue = nil)
    cmd = ""
    case queue
    when nil
      cmd = "qsub #{@sh_file}"
    when
      cmd = "qsub -q #{queue} #{@sh_file}"
    end
    #puts cmd
    system(cmd)
  end
end

if __FILE__ == $0

  command = "ls -la ./"
  options =  "#/bin/sh\n\n#! -O "
  options << "#MJS: -upc\n#MJS: -proc 1\n#MJS: -time 72:00:00"
  std_file = "fuga.err.txt"
  err_file = "hoge.err.txt"
  sh_file  = "hoge.sh" 

  sge = SGE.new(options, std_file, err_file, sh_file)
  sge.prepare("ls -la ./")

  queue = "CALC"
  sge.submit(queue)
  sge.submit
end
