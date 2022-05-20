class ProjectSerializer
  include JSONAPI::Serializer
  attributes :title

  belongs_to :user
  has_many :tasks
end
