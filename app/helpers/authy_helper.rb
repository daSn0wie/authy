module ClientsHelper
  
  def authorization_uri(client, scope)
    "/oauth/authorization?response_type=code&scope=#{scope}&client_id=#{client.uri}&redirect_uri=#{client.redirect_uri}"
  end
  
  def base_uri(request)
    protocol = request.protocol
    host = request.host_with_port
    name = self.class.name.underscore.pluralize
    id   = self.id.as_json
    uri  = protocol + host + "/" + name + "/" +  id
  end
  
  def bson_invalid_object_id(e)
    redirect_to root_path, alert: "Resource not found."
  end

  def json_parse_error(e)
    redirect_to root_path, alert: "Json not valid"
  end

  def mongoid_errors_invalid_type(e)
    redirect_to root_path, alert: "Json values is not an array"
  end
end
