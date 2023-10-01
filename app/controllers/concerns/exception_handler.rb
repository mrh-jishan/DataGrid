module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |exception|
      puts "exception-------#{exception}"
      perform_error_redirect(exception, error_message: "Error Message ---#{exception}") # I18n.t('errors.system.general'))
    end
  end

  private

  def send_error_report(exception, sanitized_status_number)
    val = true

    if sanitized_status_number == 404
      if !current_user && !request.referrer
        ### Handle Direct URL entry & Bots
        val = false
      end
    end

    if exception.class == ActionController::BadRequest
      if exception.message.start_with?('Invalid query parameters: expected ')
        val = false
      elsif exception.message.start_with?('Invalid path parameters: Invalid encoding')
        val = false
      end
    end

    return val
  end

  def get_exception_status_number(exception)
    status_number = 500

    error_classes_404 = ["ActiveRcord::RecordNotFound", "ActionController::RoutingError",]

    if error_classes_404.include?(exception.class)
      if current_user
        if request.format.html? && request.get?
          status_number = 404
        else
          status_number = 500
        end

      else
        status_number = 404
      end
    end

    return status_number.to_i
  end

  def perform_error_redirect(exception, error_message:)
    request.format ||= 'html'

    status_number = get_exception_status_number(exception)

    # if send_error_report(exception, status_number)
    #   ExceptionNotifier.notify_exception(exception, data: { status: status_number })
    # end

    # if Rails.env.development?
    #   ### To allow for the our development debugging tools
    #   raise exception
    # elsif Rails.env.test?
    #   puts exception
    #   puts backtrace
    # else
    #   logger.error exception
    #   exception.backtrace.each { |line| logger.error line }
    # end

    ### Handle XHR Requests
    if (request.format.html? && request.xhr?)
      render template: "/errors/#{status_number}.html.erb", status: status_number
      return
    end

    if status_number == 404
      if request.format.html?
        if request.get?
          render template: "/errors/#{status_number}.html.erb", status: status_number
          return
        else
          redirect_to "/#{status_number}"
        end
      else
        head status_number
      end

      return
    end

    ### Determine URL
    if request.referrer.present?
      url = request.referrer
    else
      url = "/"
      # is_admin_path = request.path.split("/").reject { |x| x.blank? }.first == 'admin'
      #
      # if current_user && is_admin_path && request.path.gsub("/", "") != admin_root_path.gsub("/", "")
      #   url = admin_root_path
      # elsif request.path != "/"
      #   url = "/"
      # else
      #   if request.format.html?
      #     if request.get?
      #       render template: "/errors/500.html.erb", status: 500
      #     else
      #       redirect_to "/500"
      #     end
      #   else
      #     head 500
      #   end
      #
      #   return
      # end
    end

    flash_message = error_message

    ### Handle Redirect Based on Request Format
    if request.format.html?
      redirect_to url, alert: flash_message
    elsif request.format.js?
      flash[:alert] = flash_message
      flash.keep(:alert)
      render js: "window.location = '#{url}';"
    else
      head status_number
    end
  end

end