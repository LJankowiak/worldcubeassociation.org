require "newrelic_rpm"

class ApplicationController < ActionController::Base
  include TimeWillTell::Helpers::DateRangeHelper
  protect_from_forgery with: :exception

  before_action :add_new_relic_headers
  protected def add_new_relic_headers
    ::NewRelic::Agent.add_custom_attributes({ user_id: current_user ? current_user.id : nil })
    ::NewRelic::Agent.add_custom_attributes({ HTTP_REFERER: request.headers['HTTP_REFERER'] })
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :email
    devise_parameter_sanitizer.for(:sign_in) << :login
    devise_parameter_sanitizer.for(:account_update) << :name << :email
  end

  private def delegates_or_team_members_only
    unless current_user && current_user.can_access_delegates_or_team_members_only_areas?
      flash[:danger] = "You are not a delegate"
      redirect_to root_url
    end
  end

  private def board_members_only
    unless current_user && current_user.can_access_board_members_only_areas?
      flash[:danger] = "You are not a board member"
      redirect_to root_url
    end
  end

  private def can_admin_results_only
    unless current_user && current_user.can_admin_results?
      flash[:danger] = "You are not allowed to administer results"
      redirect_to root_url
    end
  end

  private def can_create_posts_only
    unless current_user && current_user.can_create_posts?
      flash[:danger] = "You are not allowed to create posts"
      redirect_to root_url
    end
  end

  def date_range(from_date, to_date, options={})
    options[:separator] = '-'
    options[:format] = :long
    super(from_date, to_date, options)
  end
end
