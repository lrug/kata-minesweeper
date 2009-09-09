require 'optparse'

class UserInterface
  def initialize(command_line_args)
    cli_args_parser.parse!(command_line_args)
    
    unless @size
      puts cli_args_parser
      exit
    end
    
    @board = []
    @size[1].times do
      @board << Array.new(@size[0], 0)
    end 
    if @mines
      @mines.each do |x, y|
        @board[y - 1][x - 1] = '*'
      end
    end
  end

  def start
    # Immediately quit: no other functionality required yet.
    print_revealed_board
  end

  private
  
  def cli_args_parser
    OptionParser.new do |opts|
      opts.accept(Array, /\[.*\]/) do |arg|
        eval(arg)
      end
      
      opts.on("--size=[width,height]", :REQUIRED, Array) do |size|
        @size = size
      end
      
      opts.on("--mines=[[x,y],[x',y'], ... ]", Array) do |mines|
        @mines = mines
      end
    end
  end

  def print_revealed_board
    
    output = ''

    @board.each do |row|
      row.each do |cell|
        if cell == 0
          if @mines
            output += '1'
          else
            output += '.'
          end
        else
          output += cell.to_s
        end
      end
      output += "\n"
    end
    
    puts output
  end
    
end