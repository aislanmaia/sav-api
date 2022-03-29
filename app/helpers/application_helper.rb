module ApplicationHelper
  def serialize(result, serializer, success_status: 201, failure_status: 422)
    if result.success?
      render json: serializer.new(result.value).serialized_json, status: success_status
    else
      render json: { errors: [result.errors] }, status: result.errors[:code] || failure_status
    end
  end
end
