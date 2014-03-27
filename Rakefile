#

MECAB_DICT_BASE="mecab-naist-jdic-0.6.3b-20111013"
MECAB_DICT_URL="http://iij.dl.sourceforge.jp/naist-jdic/53500/#{MECAB_DICT_BASE}.tar.gz"
OKURA_DICDIR = 'okura-dic'

task :default => "prepare_dict"

desc "prepare dictionary"
task :prepare_dict do
  cd 'app/' do
    sh "curl #{MECAB_DICT_URL} | tar xvf -"
    sh "okura compile mecab-naist-jdic-0.6.3b-20111013/ #{OKURA_DICDIR}"
    sh "rm -rf #{MECAB_DICT_BASE}"
  end
end

# EOF
