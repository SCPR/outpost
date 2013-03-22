module Outpost
  module Controller
    module Callbacks
      def get_record
        @record = model.find(params[:id])
      end

      def get_records
        @records = model.order("#{model.table_name}.#{order} #{sort_mode}")
          .page(params[:page]).per(self.list.per_page)
      end
    end # Callbacks
  end # Controller
end # Outpost
