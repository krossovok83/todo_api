# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :projects
  has_many :tasks, through: :projects
  has_many :comments, through: :tasks
end
