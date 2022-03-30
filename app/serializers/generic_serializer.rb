class GenericSerializer
  def initialize(params)
    @params = params
  end

  def serialized_json
    @params
  end
end
