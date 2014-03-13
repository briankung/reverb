class Parser
  def self.parse(delimited_string)
    keys = %i[last_name first_name gender favorite_color birthdate]
    sanitized = self.sanitize(delimited_string) 
    Hash[keys.zip(sanitized)]
  end

  def self.sanitize(string)
    string.split(/[,|\ ]/).map(&:strip).reject(&:empty?)
  end
end