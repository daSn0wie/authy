class Authy::Scope
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :uri
  field :values, type: Array, default: []

  attr_accessible :name

  validates :name, presence: true
  validates :values, presence: true
  validates :uri, url: true

  def normalize(val)
    separator = Authy.settings["scope_separator"]
    val = val.split(separator)
  end

  def values_pretty
    separator = Authy.settings["scope_separator"]
    values.join(separator)
  end

  class << self
    # Sync all scopes with the correct exploded scope when a
    # scope is modified (changed or removed)
    def sync_scopes_with_scope(scope)
      scopes_to_sync = any_in(scope: [scope])
      scopes_to_sync.each do |client|
        scope.values = Authy.normalize_scope(scope.values)
        scope.save
      end
    end
  end
end
