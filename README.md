# Meetupanator
This is just a meetup.com console app so far.
Basically this is just a CLI tool to help you interface in a more automated way with meetup.
Give it a list of meetup names you're interested in and then run it and it can tell you what the future meetups are.

[![Build Status](https://travis-ci.org/joesustaric/meetupanator.svg?branch=master)](https://travis-ci.org/joesustaric/meetupanator)
[![Gem Version](https://badge.fury.io/rb/meetupanator.svg)](http://badge.fury.io/rb/meetupanator)

# What does it do atm?
Reads in a list of meetups from a file and writes a csv of all the ones that have future events.

# Usage
```
$ meetupanator getevents -i /location/of/input.txt -o /location/of/output.csv
```

## During development

```
$ ruby -Ilib ./bin/meetupanator ...
```

# todo
- [x] - given a file input and an output dir write a file
- [ ] - provide options for date range
- [x] - Gem this

##Spec Notes
- Using VCR gem, will call API when tests are run first time.
- Export MEETUP_API_KEY into your environment
- Times from the api are milliseconds since epoch


# Licence
some open source one. not sure yet.
