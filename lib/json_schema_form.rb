class JsonSchemaForm
  extend Rails.application.routes.url_helpers
  
  class << self
    attr_reader :title, :properties, :types, :form_attrs
    
    def title(value = nil)
      @title = value if value
      @title
    end
    
    #def properties
    #  @properties
    #end
    
    def prop(name, hash = {})
      @properties ||= {}
      @properties[name] = hash
    end
    
    #def types
    #  @types
    #end
    
    # use in property:
    #   prop ..., "$ref" => "#/definitions/name"
    #   type :name, ...
    def type(name, hash = {})
      @types ||= {}
      @types[name] = hash
    end
    
    # form my_account_path
    # form :post, my_account_path
    # form account_path(id: ':id')
    def form(http_method, action = nil)
      unless action
        action = http_method
        http_method = :get
      end
      @form_attrs = {method: http_method, action: action}
      @form_attrs
    end
    
    def url
      Rails.application.routes.url_helpers
    end
    
    def to_h
      title = @title || self.name.match(/^([A-z:]+)Form$/)[1] || self.name
      result = {title: title, type: 'object'}
      result[:properties]  = @properties if @properties && !@properties.empty?
      result[:definitions] = @types      if @types && !@types.empty?
      result[:form]        = @form_attrs if @form_attrs && !@form_attrs.empty?
      result
    end
  end
end
