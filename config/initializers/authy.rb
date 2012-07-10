module Authy
  
  def self.settings
    @settings = {
      token_expires_in: "1800"
      authorization_expires_in: "150"
      random_length: 32
      scope_separator: " "
    }
  end
  
  def self.normalize_scope(scope = [])
    scope = scope.split(" ") if scope.kind_of? String
    normalized = Scope.any_in(name: scope)
    normalized = normalized.map(&:values).flatten

    if normalized.empty?
      return self.clean(scope)
    else
      return self.clean(scope) + self.normalize_scope(normalized)
    end
  end

  # Remove 'no action' keys. For example during normalization
  # we add keys like 'pizza' (resource names) or 'pizza/read'
  # wihch we have to remove to easily make the access recognition
  # with the bearer token. 
  #
  # NOTE: at the moment are not allowed methods which contain 
  # the word "read" because it will be removed
  def self.clean(scope)
    scope = scope.keep_if   {|scope| scope =~ /\// }
    scope = scope.delete_if {|scope| scope =~ /read/ }
    scope = scope.uniq
    return scope
  end
  
  
end
