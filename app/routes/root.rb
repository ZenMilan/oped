module Oped
  module Routes
    class Root < Base
      get '/' do
        @posts = Post.all
        @num_posts = Post.count
        haml :home
      end
    end
  end
end
