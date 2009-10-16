Cryptid
===========

The cryptid plugin allows you to use crypted id to identify object identities in your routes.

To install, simply run the following command from your project.

  script/plugin install git://github.com/Frodotus/cryptid.git

Then in your ActiveRecord model classes simply add the include statement.

Example
=======

class Car < ActiveRecord::Base

  route_by :name

end

As a result of this statement, assuming your Car object has an id of 114 and
a :name attribute with the value "eleanor", your resourceful routes change from this:

  http://server.com/cars/114

to:

  http://server.com/cars/eleanor

This is good for cases where you don't want your record ids in your Urls.

Copyright (c) 2008 Gnoso Inc., released under the MIT license

