
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __gnu_CORBA_gnuContextList__
#define __gnu_CORBA_gnuContextList__

#pragma interface

#include <org/omg/CORBA/ContextList.h>
extern "Java"
{
  namespace gnu
  {
    namespace CORBA
    {
        class CorbaList;
        class gnuContextList;
    }
  }
}

class gnu::CORBA::gnuContextList : public ::org::omg::CORBA::ContextList
{

public:
  gnuContextList();
  virtual void add(::java::lang::String *);
  virtual jint count();
  virtual ::java::lang::String * item(jint);
  virtual void remove(jint);
public: // actually package-private
  ::gnu::CORBA::CorbaList * __attribute__((aligned(__alignof__( ::org::omg::CORBA::ContextList)))) strings;
public:
  static ::java::lang::Class class$;
};

#endif // __gnu_CORBA_gnuContextList__
