# frozen_string_literal: true

require 'dox'

namespace :api do
  desc 'Generate documentation for API V1'
  task dox: :environment do
    system(
      'rspec --tag apidoc -f Dox::Formatter --order defined --tag dox --out spec/api_doc/v1/docs.json'
    )
    system(
      'redoc-cli bundle -o public/api/docs/v1/docs.html spec/api_doc/v1/docs.json'
    )
  end
end
