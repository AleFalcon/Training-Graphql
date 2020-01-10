class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = RailsGraphqlBootstrapSchema.execute(
      query, variables: variables, context: context, operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      handle_param_string(ambiguous_param)
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_param_string(param)
    return ensure_hash(JSON.parse(param)) if param.present?

    {}
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render json: { error: { message: err.message, backtrace: err.backtrace }, data: {} },
           status: :internal_server_error
  end

  def variables
    ensure_hash(params[:variables])
  end

  def query
    params[:query]
  end

  def operation_name
    params[:operationName]
  end
end
