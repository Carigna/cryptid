# Cryptid

The cryptid plugin allows you to use crypted id to identify object identities in your routes.

## Installation

To install, simply run the following command from your project.

  script/plugin install git://github.com/Frodotus/cryptid.git

Then in your ActiveRecord model classes simply add the include statement.

## Usage

    class Foo < ActiveRecord::Base

        include Cryptid

    end

As a result of this statement, assuming your Foo object has an id of 144, your resourceful routes
change from this:

    http://server.com/foos/114

to:

    http://server.com/foos/9873498273400000144

By using ids with checksum web user can not view other resources by just adding ids.


## License
BrowserCMS is released under a MIT license, and is copyright 2009 Carigna Oy. Copy of the license can be found in LICENSE.txt.
