require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/msg'

class MsgTest < Minitest::Test
  def test_replacements
    headers = %w(state bird)
    data = %w(California quail)
    template = "Fun fact about {{state}}\n\nThe state bird in {{state}} is {{bird}}. We serve {{bird}} fried."
    row = CSV::Row.new(headers, data)

    msg = Msg.new(row, template)
    assert_equal "Fun fact about California", msg.subject
    assert_equal "The state bird in California is quail. We serve quail fried.", msg.body
  end

  def test_nil_csv_data_is_fine_when_not_used_in_template
    headers = %w(name number favorite)
    data = %w(Alice one)

    template = "{{name}} is number {{number}}."
    row = CSV::Row.new(headers, data)
    msg = Msg.new(row, template)
    assert_equal "Alice is number one.", msg.subject
  end

  def test_nil_csv_data_blows_up_if_template_needs_it
    headers = %w(name number favorite)
    data = %w(Alice one)

    template = "{{number}}: {{name}} likes {{favorite}}."
    row = CSV::Row.new(headers, data)
    e = assert_raises(Msg::MissingAttribute) do
      msg = Msg.new(row, template)
    end
    assert_equal "missing value for 'favorite' attribute", e.message
  end
end

