Lovely Rufus
============

Lovely Rufus is an executable and a Ruby library for wrapping paragraphs of text in the spirit of [Par](http://www.nicemice.net/par/).



Usage
-----

Lovely Rufus can be used from the command-line by piping text through the `lovely-rufus` executable:

    $ echo 'The Ballyshannon foundered off the coast of Cariboo, And down in fathoms many went the captain and the crew;' | lovely-rufus
    The Ballyshannon foundered off the coast of Cariboo,
    And down in fathoms many went the captain and the crew;

Lovely Rufus can also be used from Ruby code through the `TextWrapper` class:

    $ irb
    >> require 'lovely_rufus'
    >> text = 'The Ballyshannon foundered off the coast of Cariboo, And down in fathoms many went the captain and the crew;'
    >> puts LovelyRufus::TextWrapper.wrap text
    The Ballyshannon foundered off the coast of Cariboo,
    And down in fathoms many went the captain and the crew;

Note that `TextWrapper.wrap` can take optional desired width:

    $ irb
    >> require 'lovely_rufus'
    >> text = 'The Ballyshannon foundered off the coast of Cariboo, And down in fathoms many went the captain and the crew;'
    >> puts LovelyRufus::TextWrapper.wrap text, width: 15
    The
    Ballyshannon
    foundered off
    the coast of
    Cariboo, And
    down in fathoms
    many went the
    captain and
    the crew;



Features
--------

Currently, Lovely Rufus sports the following features:

* paragraphs are wrapped to the specified width,
* one-letter words are not left at ends of lines,
* email quotes (`>`) are handled properly and normalised (`> > >` → `>>>`),
* email-quoted paragraph breaks are cleared,
* code comments (starting with `#` and `//`) are handled properly,
* multiple paragraphs are wrapped independently.



Name and history
----------------

Lovely Rufus was created as a [Ruby Mendicant University](http://blog.majesticseacreature.com/tag/rubymendicant) project and is named after [a certain _Love Actually_ character](http://en.wikipedia.org/wiki/Love_Actually#Rufus) who’s [exceptionally good at wrapping](http://www.youtube.com/watch?v=W6E1wPwOaE4).



---

© MMX-MMXIV Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL-3.0 (see LICENCE)
