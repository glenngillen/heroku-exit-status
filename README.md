# heroku-exit-status

Make the `heroku` command return the exit status from your one-off dyno process.

## Installation


    $ heroku plugins:install https://github.com/glenngillen/heroku-exit-status.git

## Usage

Just use `heroku run` like you normally would

    $ heroku run ls
    Running `ls` attached to terminal... up, run.1
    app  bin  config  config.ru  db  doc  Gemfile  Gemfile.lock  lib  log  Procfile  public  Rakefile  script  server  test  tmp  vendor
    $ echo $?
    0

    $ heroku run no-such-command
    Running `no-such-command` attached to terminal... up, run.1
    bash: no-such-command: command not found
    $ echo $?
    127

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Analytics](https://ga-beacon.appspot.com/UA-46840117-1/heroku-exit-status/readme?pixel)](https://github.com/igrigorik/ga-beacon)
