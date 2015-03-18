module Oped
  module Routes
    class Root < Base
      get '/' do
        @num_posts = Post.count
        @posts = Post.all
        haml :home
      end
    end
  end
end
