require 'date'

class Record < Hash
  KEYS = %i[last_name first_name gender favorite_color birthdate]

  def initialize(delimited_string)
    self.merge!(Record.parse(delimited_string))
  end

  def display
    "Last Name: #{self[:last_name]}, First Name: #{self[:first_name]}, Gender: #{self[:gender]}, Date of Birth: #{birthdate}"
  end

  private

  def birthdate
    Date.parse(self[:birthdate]).strftime("%m/%d/%Y")
  end

  def self.parse(delimited_string)
    sanitized = self.sanitize(delimited_string) 
    Hash[KEYS.zip(sanitized)]
  end

  def self.sanitize(string)
    string.split(/[,|\ ]/).map(&:strip).reject(&:empty?)
  end
end