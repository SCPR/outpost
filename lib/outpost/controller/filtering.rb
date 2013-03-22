module Outpost
  module Controller
    module Filtering
      private

      def filter_records
        if params[:filter].is_a? Hash
          params[:filter].each do |attribute, value|
            next if value.blank?
            scope = "filtered_by_#{attribute}"

            if @records.klass.respond_to? scope
              @records = @records.send(scope, value)
            else
              @records = @records.where(attribute => value)
            end
          end
        end
      end
    end
  end
end
