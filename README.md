# Bitbucket post to Backlog

BitbucketのWEB APIのパラメータを利用し、バックログにpostします。
sinatraで作っているので、HEROKUなどにそのままデプロイしてください。

## API REFERENCE

・bitbucket API
https://confluence.atlassian.com/display/BITBUCKET/POST+Service+Management

・backlog API
http://www.backlog.jp/api/


## Installation Exsample HEROKU

    $ heroku create ${your_app}
    $ git ci -m "initial commit"
    $ git push heroku master

## Setting URL of bitbucket

http://${heroku domain}/backlog

## Configuration(conf.yml)

    backlog:
      user : '${backlog_user}'
      password : '${backlog_password}'
      key : '${backlog_key}' # http://${key}.backlog.jp
      projects : #複数設定可能です
        - '${YOUR_PROJECT}'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

