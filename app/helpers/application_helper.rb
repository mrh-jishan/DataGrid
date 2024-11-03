module ApplicationHelper
  include Pagy::Frontend

  DEFAULT_ALERT_CLASS = "alert alert-primary alert-dismissible fade show".freeze
  ALERT_CLASS = {
    :notice => "alert alert-info alert-dismissible fade show",
    :success => "alert alert-success alert-dismissible fade show",
    :error => "alert alert-danger alert-dismissible fade show",
    :alert => "alert alert-danger alert-dismissible fade show"
  }

  def flash_class(level)
    ALERT_CLASS[level.to_sym] || DEFAULT_ALERT_CLASS
  end

  def render_breadcrumbs
    content_tag(:nav, breadcrumbs_list, class: "mt-2", aria: { label: 'breadcrumb' })
  end

  private

  def breadcrumbs_list
    content_tag(:ol, breadcrumbs_items, class: 'breadcrumb')
  end

  def breadcrumbs_items
    breadcrumbs.map { |breadcrumb| breadcrumb_item(breadcrumb) }.join.html_safe
  end

  def breadcrumb_item(breadcrumb)
    content_tag(:li, class: breadcrumb[:current] ? 'breadcrumb-item active' : 'breadcrumb-item') do
      if breadcrumb[:current]
        breadcrumb[:text]
      else
        link_to(breadcrumb[:text], breadcrumb[:path])
      end
    end
  end

  def breadcrumbs
    controllers = params[:controller].split('/')
    controllers.map.with_index do |controller, index|
      {
        text: controller.humanize,
        path: url_for(controller: params[:controller], action: params[:action], only_path: true),
        current: index == controllers.length - 1
      }
    end
  end
end
