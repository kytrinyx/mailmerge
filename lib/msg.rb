class Msg
  class MissingAttribute < StandardError; end

  attr_reader :csv_row, :subject, :body
  def initialize(csv_row, contents)
    @csv_row = csv_row
    csv_row.each do |key, value|
      placeholder = "{{%s}}" % key
      next if !contents.include?(placeholder)

      if value.nil?
        raise MissingAttribute, "missing value for '%s' attribute" % key
      end
      contents = contents.gsub(placeholder, value)
    end

    @subject, *lines = contents.split("\n")
    @body = lines.join("\n").strip
  end

  def email
    csv_row['email']
  end
end
