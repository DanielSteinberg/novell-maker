module ApplicationHelper
  def render_flash(key = nil)
    if key && flash[key]
      flash.discard(key)
      render_flash_block(key, flash[key])
    else
      res = '';
      flash.discard
      flash.each do |key, value|
        res << render_flash_block(key, value)
      end
      res.html_safe
    end
  end
  
  def render_flash_block(key, value)
    content_tag(:p, value, class: "flash #{key}")
  end
  
  def render_errors(object)
    if !object.respond_to?(:errors) || object.errors.empty?
      ''
    else
      object.errors.messages.values.flatten.reduce('') do |a, e|
        a + content_tag(:p, e, class: "validation-error #{object.class.name.underscore}")
      end.html_safe
    end
  end
end
