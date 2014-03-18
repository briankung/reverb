class RecordSet < Array
  def initialize(file)
    File.open(file).each_line do |l|
      self << Record.new(l)
    end
  end
end