class ApplicationController < ActionController::API
  attr_reader :current_user

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

  def paginate data
    page = params[:page].to_i
    per_page = 2
    skip_pages = page > 1 ? 2 * (page - 1) : 0
    total = data.count / per_page

    {
        data: data.limit(per_page).skip(skip_pages),
        total_pages: total
    }
  end

  private

  def auth_api
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: {error: 'Not Authorized'}, status: 401 unless @current_user
  end
end
