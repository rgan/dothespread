module ApplicationHelper

  def error_message_list(model)
    return nil unless model

    errors = model.errors

    if !errors.empty?
      message_list = ""

      errors.full_messages.each do |error|
        message_list << content_tag("li", error)
      end
      content_tag("div", content_tag("ul", message_list), :class => "msgError")
    end
  end

end
