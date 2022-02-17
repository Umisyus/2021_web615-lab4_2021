rvm install $(cat .ruby-version) && rvm $(cat .ruby-version) do rvm gemset create $(cat .ruby-gemset) && rvm gemset use $(cat .ruby-gemset)
gem install bundler:1.17.3
bundle install
bin/setup
