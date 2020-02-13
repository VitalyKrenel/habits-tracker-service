class ApplicationController < ActionController::API
  def parse_request(required_fields = [])

    errors = {}
    success = {}

    if required_fields.empty?

      params.each do |key, value|
        unless value.empty?
          success[key] = value
        end
      end

      return success
    end


    required_fields.each do |field|
      if params[field].nil? or params[field].empty?
        errors[field] = field + " is required"
      else
        success[field] = params[field]
      end
    end


    if errors.count != 0
      raise Exception.new(errors.to_s)
    end

    success
  end
end
