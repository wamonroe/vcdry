class CallbackComponent < ApplicationComponent
  after_initialize -> { @links = [] }

  def with_link(**options)
    @links << options
  end
end
