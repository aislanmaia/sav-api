# class UsersSerializer < GenericSerializer
#   def serialized_json
#     @params.map do |data|
#       {
#         "id": data[:id].to_s,
#         "username": data[:username].to_s,
#         "firstname": data[:firstname].to_s,
#         "lastname": data[:lastname].to_s,
#         "email": data[:email].to_s,
#         "registry": data[:registry].to_s
#       }
#     end
#   end
# end

class UserSerializer
  include ::ActiveModel::Serializers
  attributes :id, :username, :firstname, :lastname, :email, :registry
end