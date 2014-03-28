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
        tagger.parse(s).mincost_path.map do |n|
          {surface: "#{n.word.surface}", text: "#{n.word.left.text.split /,/}"}
        end
      end
    end

    resource :wakati do
      post do
        s = params[:text]
        return [] unless s
        tagger.wakati s
      end
    end
  end

end

# EOF
