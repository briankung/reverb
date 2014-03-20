require_relative 'record'

class RecordSet < Array
  def initialize(input_file)
    @file ||= File.open(input_file)
    @file.each_line do |l|
      self << Record.new(l)
    end
    @file.close
  end

  def list(order: :birthdate)
    if order == :gender then list_by_gender else self.sort_by {|r| r[order]} end
  end

  def display(order: :birthdate)
    list(order: order).map(&:display)
  end

  def save!
    File.open(@file, 'w') do |f| 
      self.each {|record| f.puts "%s, %s, %s, %s, %s" % record.values }
    end
  end

  private

  def list_by_gender
    (women + men)
  end

  def women
    self.select {|r| r[:gender] == "Female" }.sort_by {|r| r[:last_name]}    
  end

  def men
    self.select {|r| r[:gender] == "Male" }.sort_by {|r| r[:last_name]}
  end
end