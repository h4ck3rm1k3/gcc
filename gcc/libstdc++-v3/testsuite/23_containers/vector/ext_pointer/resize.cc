
// Copyright (C) 2008
// Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 2, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING.  If not, write to the Free
// Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
// USA.

// As a special exception, you may use this file as part of a free software
// library without restriction.  Specifically, if other files instantiate
// templates or use macros or inline functions from this file, or you compile
// this file and link it with other files to produce an executable, this
// file does not by itself cause the resulting executable to be covered by
// the GNU General Public License.  This exception does not however
// invalidate any other reasons why the executable file might be covered by
// the GNU General Public License.

#include <vector>
#include <stdexcept>
#include <testsuite_allocator.h>
#include <testsuite_hooks.h>
#include <ext/extptr_allocator.h>


void test01()
{
  // non POD types
  bool test __attribute__((unused)) = true;
  
  std::vector<int, __gnu_cxx::_ExtPtr_allocator<int> > vec01;
  typedef std::vector<int, __gnu_cxx::_ExtPtr_allocator<int> >::size_type size_type;

  VERIFY(vec01.empty());

  const int A[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };    

  // Test resize of the vector based on reserve
  size_type sz01 = vec01.capacity();
  vec01.reserve(100);
  size_type sz02 = vec01.capacity();
  VERIFY(sz02 >= sz01);

  // grow/shrink
  vec01.assign( A, A+10 );
  sz01 = vec01.size() + 100;
  vec01.resize(sz01);
  sz02 = vec01.size();
  VERIFY(sz01 == sz02);
  VERIFY(std::equal(vec01.begin(), vec01.begin()+10, A));
  
  sz01 = vec01.size() - 100;
  vec01.resize(sz01);
  sz02 = vec01.size();
  VERIFY(sz01 == sz02);
  VERIFY(std::equal(vec01.begin(), vec01.end(), A));
}

int main()
{
  test01();
  return 0;
}
