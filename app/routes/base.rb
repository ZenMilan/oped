module Oped
  module Routes
    class Base < Sinatra::Application
      configure do
        set :views, 'app/views'
        set :root, App.root

        disable :method_override
        disable :protection
        disable :static

        set :haml, format: :html5
        @num_posts = ::Oped::Models::Post.count
      end

      helpers Helpers
      helpers Sinatra::ContentFor
    end
  end
end
