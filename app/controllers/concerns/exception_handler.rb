module ExceptionHandler
  # provides the `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :bad_request)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      json_response({ message: e.message[/Key .* already exists/] }, :conflict)
    end
  end
end
