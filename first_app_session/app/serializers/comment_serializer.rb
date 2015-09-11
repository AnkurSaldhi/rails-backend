class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :micropost_id
end
