
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __java_util_concurrent_CompletionService__
#define __java_util_concurrent_CompletionService__

#pragma interface

#include <java/lang/Object.h>

class java::util::concurrent::CompletionService : public ::java::lang::Object
{

public:
  virtual ::java::util::concurrent::Future * submit(::java::util::concurrent::Callable *) = 0;
  virtual ::java::util::concurrent::Future * submit(::java::lang::Runnable *, ::java::lang::Object *) = 0;
  virtual ::java::util::concurrent::Future * take() = 0;
  virtual ::java::util::concurrent::Future * poll() = 0;
  virtual ::java::util::concurrent::Future * poll(jlong, ::java::util::concurrent::TimeUnit *) = 0;
  static ::java::lang::Class class$;
} __attribute__ ((java_interface));

#endif // __java_util_concurrent_CompletionService__
