module ApplicationHelper

  def error_message_list(model)
    return nil unless model

    errors = model.errors

    if !errors.empty?
      message_list = ""

      errors.full_messages.each do |error|
        message_list << error
      end
      message_list
    end
  end

end
