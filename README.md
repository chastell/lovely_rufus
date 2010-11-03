Lovely Rufus
============

Lovely Rufus is an executable and a Ruby library for wrapping paragraphs of text in the spirit of [Par](http://www.nicemice.net/par/).



usage
-----

Lovely Rufus can be used from the command-line by piping text through the `rufus` executable:

    $ echo 'The Ballyshannon foundered off the the coast of Cariboo, and down in fathoms many went the captain and the crew.' | rufus
    The Ballyshannon foundered off the the coast of Cariboo, and down in
    fathoms many went the captain and the crew.
    $

Lovely Rufus can also be used from Ruby code through the `Wrapper` class:

    $ irb
    >> text = 'The Ballyshannon foundered off the the coast of Cariboo, and down in fathoms many went the captain and the crew.'
    >> puts LovelyRufus::Wrapper.new(text).wrapped
    The Ballyshannon foundered off the the coast of Cariboo, and down in
    fathoms many went the captain and the crew
    >>



name and history
----------------

Lovely Rufus was created as a [Ruby Mendicant University](http://blog.majesticseacreature.com/tag/rubymendicant) project and is named after [a certain _Love Actually_ character](http://en.wikipedia.org/wiki/Love_Actually#Rufus) who’s [exceptionally good at wrapping](http://www.youtube.com/watch?v=W6E1wPwOaE4).



---

© MMX Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
