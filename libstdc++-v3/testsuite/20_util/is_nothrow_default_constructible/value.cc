// { dg-options "-std=gnu++0x" }
// 2004-12-29  Paolo Carlini  <pcarlini@suse.de>
//
// Copyright (C) 2004, 2005, 2006, 2007, 2009, 2011
// Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

#include <type_traits>
#include <testsuite_hooks.h>
#include <testsuite_tr1.h>

void test01()
{
  bool test __attribute__((unused)) = true;
  using std::is_nothrow_default_constructible;
  using namespace __gnu_test;

  // Positive tests.  
  VERIFY( (test_category<is_nothrow_default_constructible, int>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, float>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, EnumType>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, int*>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int(*)(int)>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int (ClassType::*)>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int (ClassType::*) (int)>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, int[2]>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   EnumType[2][3][4]>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, int*[3]>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int (ClassType::*[2][3])>(true)) );
  VERIFY( (test_category<is_nothrow_default_constructible, ClassType>(true)) );

  VERIFY( (test_category<is_nothrow_default_constructible,
	   NoexceptDefaultClass>(true)) );

  // Negative tests.
  VERIFY( (test_category<is_nothrow_default_constructible, void>(false)) );
  VERIFY( (test_category<is_nothrow_default_constructible, int[]>(false)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   float[][3]>(false)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int(*[][2])(int)>(false)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   int (ClassType::*[][2][3]) (int)>(false)) );

  VERIFY( (test_category<is_nothrow_default_constructible,
	   ThrowDefaultClass>(false)) );
  VERIFY( (test_category<is_nothrow_default_constructible,
	   ExceptDefaultClass>(false)) );
}

int main()
{
  test01();
  return 0;
}
