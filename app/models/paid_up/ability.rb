# frozen_string_literal: true

module PaidUp
  # PaidUp Ability model
  module Ability
    include CanCan::Ability

    def initialize_paid_up(user)
      PaidUp::Feature.all.each do |feature|
        method = "enable_#{feature.setting_type}".to_sym
        send(method, user, feature)
      end
    end

    private

    def enable_rows(model, allowed, remaining)
      can :index, model
      can :show, model, &:enabled?
      if allowed.positive?
        can :own, model
        cannot :create, model
        can(%i(create new), model) if remaining.positive?
      else
        cannot %i(delete update own create), model
      end
    end

    def enable_table_rows(user, feature)
      slug = feature.slug
      model = feature.feature_model
      allowed = user.table_rows_allowed(slug)
      remaining = user.table_rows_remaining(slug)
      can :manage, model, user: user if allowed.positive?
      enable_rows(model, allowed, remaining)
    end

    def enable_rolify_rows(user, feature)
      slug = feature.slug
      model = feature.feature_model
      allowed = user.rolify_rows_allowed(slug)
      remaining = user.rolify_rows_remaining(slug)
      if allowed.positive?
        can :manage, model, id: model.with_role(:owner, user).ids
      end
      enable_rows(model, allowed, remaining)
    end

    def enable_boolean(user, feature)
      slug = feature.slug
      can :use, slug.to_sym if user.plan.feature_setting slug
    end
  end
end
