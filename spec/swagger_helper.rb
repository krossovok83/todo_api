# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'ToDo API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://todo-api-korzhov.herokuapp.com ',
          variables: {
            defaultHost: {
              default: 'todo-api-korzhov.herokuapp.com'
            }
          }
        }
      ],
      consumes: %w[application/json multipart/form-data],
      components: {
        schemas: {
          project: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              title: { type: 'string' }
            },
            required: %w[id title user]
          },
          new_project: {
            type: 'object',
            properties: {
              title: { type: 'string' },
              user: {
                type: 'object',
                properties: {
                  id: { type: 'integer' }
                }
              }
            },
            required: %w[title user]
          },
          user: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              email: { type: 'string' },
              token: { type: 'string' }
            },
            required: %w[id email]
          },
          new_user: {
            type: 'object',
            properties: {
              email: { type: 'string' },
              password: { type: 'string' },
              password_confirmation: { type: 'string' }
            },
            required: %w[email password password_confirmation]
          },
          auth_user: {
            type: 'object',
            properties: {
              email: { type: 'string' },
              password: { type: 'string' }
            },
            required: %w[email password]
          },
          new_task: {
            type: 'object',
            properties: {
              title: { type: 'string' },
              deadline: { type: 'datetime', 'x-nullable': true },
              position: { type: 'integer' },
              completed: { type: 'boolean' },
              project: {
                type: 'object',
                properties: {
                  id: { type: 'integer' }
                }
              }
            },
            required: %w[title project]
          },
          task: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              title: { type: 'string' },
              deadline: { type: 'datetime', 'x-nullable': true },
              completed: { type: 'boolean' },
              position_down: { type: 'boolean', 'x-nullable': true },
              position_up: { type: 'boolean', 'x-nullable': true }
            },
            required: %w[id title project]
          },
          new_comment: {
            type: 'object',
            properties: {
              body: { type: 'string', 'x-nullable': true },
              image: { type: 'file', 'x-nullable': true },
              task: {
                type: 'object',
                properties: {
                  id: { type: 'integer' }
                }
              }
            }
          }
        },
        securitySchemes: {
          Access: {
            type: :apiKey,
            name: 'Authorization',
            in: :header,
            description: 'Bearer <token>'
          },
          Refresh: {
            type: :apiKey,
            name: 'X-Refresh-Token',
            in: :header,
            description: '<token>'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
