[![Actions Status](https://github.com/tomajask/ruby-logs-parser-on-docker/workflows/CI/badge.svg)](https://github.com/tomajask/ruby-logs-parser-on-docker/actions)

# Simple log files parser written in Ruby on Docker

## Prerequisites

* Docker

## Development
To enter the docker container with the shell run following command:
```bash
make dev
```
It will build the app's Docker image, start container and run shell inside the container.

To enter the app's Ruby console, run following command inside the Docker container:
```bash
pry
```
It will load all files, classes automatically.

## Tests
To run tests run following command:
```bash
make test
```
It will build Docker image, start container and run `rubocop` and `rspec` inside. It will print results and test coverage.

## Usage
Example file with logs is placed in `source/data/` directory as `webserver.log` file.
To parse logs from this file run following command in Ruby console:
```ruby
LogsProcessor.new.process(filepath: "data/webserver.log")
```

Or simply run this script inside the container:
```bash
bin/parser.rb data/webserver.log
```

Or use `make` command:
```bash
make run
```

It will read log file, parse logs and print the result:
```
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits
```
