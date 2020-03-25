After building development container:

1. `rbenv install`
2. `rbenv rehash`
3. `gem install bundler`
4. `bundle install`
5. `rbenv rehash`

Heroku:

1. `curl https://cli-assets.heroku.com/install.sh | sh`
2. `heroku login -i`
3. `heroku git:remote --app cf-dev-tools`
4. `git push heroku master`
