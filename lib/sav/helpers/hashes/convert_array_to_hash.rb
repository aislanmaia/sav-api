module Sav
  module Helpers
    module Hashes
      class ConvertArrayToHash
        def initialize(array)
          @array = array
        end

        def value
          convert_array_to_hash(@array)
        end

        private

        def convert_array_to_hash(array)
          array.each_with_object({}) do |elem, hash|
            hash[elem.to_sym] = elem
            hash
          end
        end
      end
    end
  end
end
