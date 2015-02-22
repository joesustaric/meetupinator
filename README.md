# meetupinator
This is just a meetup.com console app so far.
Basically this is just a CLI tool to help you interface in a more automated way with meetup.
Give it a list of meetup names you're interested in and then run it and it can tell you what the future meetups are.

[![Build Status](https://travis-ci.org/joesustaric/meetupinator.svg?branch=master)](https://travis-ci.org/joesustaric/meetupinator)
[![Gem Version](https://badge.fury.io/rb/meetupinator.svg)](http://badge.fury.io/rb/meetupinator)

# What does it do atm?
Reads in a list of meetups from a file and writes a csv of all the ones that have future events.

# Usage
```
$ meetupinator getevents -i /location/of/input.txt -o /location/of/output.csv
```
or  
```
$ meetupinator getevents -i /location/of/input.txt
```
This will write a otuput.csv to the current directory.

## During development

```
$ bundle exec ./bin/meetupinator ...
```

# todo
- [x] - given a file input and an output dir write a file
- [ ] - provide options for date range
- [x] - Gem this

# Licence
[MIT](https://github.com/joesustaric/meetupinator/blob/master/LICENSE.md)
