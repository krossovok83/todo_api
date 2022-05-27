# frozen_string_literal: true

JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials.jwt[:secret].to_s
JWTSessions.access_exp_time = 3600
JWTSessions.refresh_exp_time = 604_800
