class HaveInstanceVariable
  NOT_DEFINED = Object.new.freeze

  def initialize(instance_variable, with_value: NOT_DEFINED, with_type: NOT_DEFINED)
    @instance_variable = instance_variable
    @expected_value = with_value
    @expected_type = with_type
  end

  def matches?(component)
    @component = component
    if expected_value? && expected_type?
      expected_value_matches? && expected_type_matches?
    elsif expected_value?
      expected_value_matches?
    elsif expected_type?
      expected_type_matches?
    else
      @component.instance_variable_defined?(@instance_variable)
    end
  end

  def failure_message
    message = "expected #{@component.inspect} to have instance variable #{@instance_variable}"
    if expected_value? && !expected_value_matches?
      message += " with value #{@expected_value.inspect} (got #{actual_value.inspect})" if expected_value?
    elsif expected_type? && !expected_type_matches?
      message += " with type #{@expected_type.inspect} (got #{actual_value.class.inspect})"
    end
    message
  end

  def failure_message_when_negated
    message = "expected #{@component.inspect} not to have instance variable #{@instance_variable}"
    if expected_value? && expected_value_matches?
      message += " with value #{actual_value.inspect})" if expected_value?
    elsif expected_type? && expected_type_matches?
      message += " with type #{actual_value.class.inspect}"
    end
    message
  end

  private

  def actual_value
    @component.instance_variable_get(@instance_variable)
  end

  def expected_value?
    @expected_value != NOT_DEFINED
  end

  def expected_value_matches?
    @expected_value == actual_value
  end

  def expected_type?
    @expected_type != NOT_DEFINED
  end

  def expected_type_matches?
    actual_value.is_a?(@expected_type)
  end
end

def have_instance_variable(...)
  HaveInstanceVariable.new(...)
end
