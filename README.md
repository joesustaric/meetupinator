# meetupinator
This is just a meetup.com console app so far.
Basically this is just a CLI tool to help you interface in a more automated way with meetup.
Give it a list of meetup names you're interested in and then run it and it can tell you what the future meetups are.

![Simpsons Meetup](https://frinkiac.com/meme/S09E05/596778.jpg?b64lines=)

[![Build Status](https://travis-ci.org/joesustaric/meetupinator.svg?branch=master)](https://travis-ci.org/joesustaric/meetupinator)
[![Gem Version](https://badge.fury.io/rb/meetupinator.svg)](http://badge.fury.io/rb/meetupinator)

# What does it do atm?
* Reads in a list of meetups from a file and writes a csv of all the ones that have future events.
* Reads in a list of meetups from a CSV file and uses an ERB template to format that list nicely.

# Usage
## Retrieving events
You must specify a input file and key or have your key in your ENV as MEETUP_API_KEY
```
$ meetupinator -i /location/of/input.txt -o /location/of/output.csv -k your_api_key_1234abcd -w 1
```
or this will get all the up and coming events
```
$ meetupinator  -i /location/of/input.txt
```
or for two weeks worth of events  
```
$ meetupinator  -i /location/of/input.txt -w 2
```

This will write a otuput.csv to the current directory.

## Formatting
```
$ meetupinator format -i /location/of/input.csv -o /location/of/output.whatever -t /location/of/template.whatever.erb
```

or, to use the default output location (output.html) and default template:

```
$ meetupinator format -i /location/of/input.csv -o /location/of/output.whatever -t /location/of/template.whatever.erb
```

## During development

```
$ bundle exec ./bin/meetupinator ...
```

# Licence
[MIT](https://github.com/joesustaric/meetupinator/blob/master/LICENSE.md)
