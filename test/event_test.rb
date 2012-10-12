# Copyright (C) 2012 Paul Van de Vreede
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require './helper'

class EventTest < Test::Unit::TestCase

  def setup
    @event = create_event
  end

  def test_equals
    # check and see if it supers non-hashes
    assert !(@event == "a string"), "should return false for a string."

    # test exact match
    assert (@event == { :first => "1", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."

    # test all event elements plus extras
    assert (@event == { :first => "1", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."

    # test false when hash key is different
    assert !(@event == { :first_wrong => "1", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."
    assert !(@event == { :first_wrong => "1", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."

    # test false when hash value is different
    assert !(@event == { :first => "wrong", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."
    assert !(@event == { :first => "wrong", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."
  end

end