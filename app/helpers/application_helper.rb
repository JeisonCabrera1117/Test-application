module ApplicationHelper
  def remote_form(resource, options = {}, &block)
    default_options = { remote: true }
                      .deep_merge(stimulus_options)

    form_for(
      resource,
      default_options.deep_merge(options),
      &block
    )
  end

  def stimulus_options(options = {})
    { data: { action: 'ajax:error->form#onPostError' }.merge(options) }
  end

  def controlled_form(&block)
    tag.div(data: { controller: 'form' }) do
      tag.div(data: { target: 'form.content' }, &block)
    end
  end

  def flash_class(level)
    case level.to_sym
    when :notice
      'bg-info'
    when :success
      'bg-success'
    when :error
      'bg-danger'
    when :alert
      'bg-danger'
    when :survey
      'bg-dark'
    else
      'bg-info'
    end
  end
end
