module Oped
  module Routes
    class Root < Base
      get '/' do
        @posts = Post.all
        erb :home
      end
    end
  end
end
