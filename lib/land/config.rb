# frozen_string_literal: true

module Land
  class Config < HashWithIndifferentAccess
    ALLOWED_NEW_VISIT_REASONS = %w[referer_changed? attribution_changed? user_agent_changed? visit_stale?]
    attr_reader :enabled, :secure_cookie

    attr_writer :blank_user_agent_string
    attr_writer :schema, :untracked_ips, :untracked_paths

    def initialize
      @enabled = false
      @secure_cookie = false
    end

    def blank_user_agent_string
      @blank_user_agent_string ||= 'user agent missing'
    end

    def enabled=(value)
      raise ArgumentError unless [true, false].include?(value)

      @enabled = value
    end

    def secure_cookie=(value)
      raise ArgumentError unless [true, false].include?(value)

      @secure_cookie = value
    end

    def schema
      @schema ||= 'land'
    end

    def untracked_ips
      @untracked_ips ||= []
    end

    def add_untracked_ip(ip)
      @untracked_ips << ip
    end

    def untracked_paths
      @untracked_paths ||= []
    end

    def add_untracked_path(path)
      @untracked_paths << path
    end

    def visit_timeout
      @visit_timeout ||= 30.minutes
    end

    def visit_timeout=(value)
      raise ArgumentError unless [Integer, ActiveSupport::Duration].include?(value.class)
      raise ArgumentError, "must be positive" unless value.positive?

      @visit_timeout = value
    end

    def new_visit_reasons
      @new_visit_reasons ||= %w[referer_changed? attribution_changed?  user_agent_changed? visit_stale?]
    end

    def new_visit_reasons=(value)
      raise ArgumentError, "must be an array of strings" unless value.is_a?(Array) && value.all? { |v| v.is_a?(String) }
      raise ArgumentError, "must be a subset of #{ALLOWED_NEW_VISIT_REASONS}" unless (value - ALLOWED_NEW_VISIT_REASONS).empty?
      @new_visit_reasons = value
    end
  end
end
