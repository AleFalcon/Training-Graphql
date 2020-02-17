class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  def execute
    context = generate_context(session)
    result = RailsGraphqlBootstrapSchema.execute(
      query, variables: variables, context: context, operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def generate_context(session)
    {
      session: session,
      current_user: current_user
    }
  end

  def current_user
    return unless session[:token]
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application
      .secrets[:secret_key_base].byteslice(0..31))
    token = crypt.decrypt_and_verify session[:token]
    user_id = token.gsub('user-id:', '').to_i
    User.find_by id: user_id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

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
