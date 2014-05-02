# https://github.com/amatsuda/kaminari/issues/457
module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        t = @options[:route_proxy] || @template

        # master 0.15.1 changed this method from 0.15.1 release in
        # 544acb4deb8dd9b9f369553b4af4d0eee788e40f
        if respond_to?(:params_for)
          t.url_for params_for(page).merge(:only_path => true)
        else
          t.url_for @params.merge(@param_name => (page <= 1 ? nil : page))
        end
      end
    end
  end
end
