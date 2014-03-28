#

require 'grape'
require 'okura/serializer'

module OkuraWeb
  OKURA_DICDIR = './app/okura-dic'

  class API < Grape::API
    prefix 'okura'
    format :json
    default_format :json

    helpers do
      def tagger
        @tagger ||= Okura::Serializer::FormatInfo.create_tagger OKURA_DICDIR
      end
    end

    resource :morph do
      post do
        s = params[:text]
        return [] unless s
        nodes = tagger.parse params[:text]
        nodes.mincost_path.map do |node|
          word = node.word
          {surface: "#{word.surface}", text: "#{word.left.text.split /,/}"}
        end
      end
    end

    resource :wakati do
      post do
        return [] unless params[:text]
        tagger.wakati params[:text]
      end
    end
  end

end

# EOF
