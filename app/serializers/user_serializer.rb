class UserSerializer < GenericSerializer
  def serialized_json
    {
      "id": @params[:id].to_s,
      "username": @params[:username].to_s,
      "firstname": @params[:firstname].to_s,
      "lastname": @params[:lastname].to_s,
      "email": @params[:email].to_s,
      "registry": @params[:registry].to_s
    }
  end
end
