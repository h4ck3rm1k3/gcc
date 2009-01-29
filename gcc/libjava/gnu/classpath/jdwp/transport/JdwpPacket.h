
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __gnu_classpath_jdwp_transport_JdwpPacket__
#define __gnu_classpath_jdwp_transport_JdwpPacket__

#pragma interface

#include <java/lang/Object.h>
#include <gcj/array.h>

extern "Java"
{
  namespace gnu
  {
    namespace classpath
    {
      namespace jdwp
      {
        namespace transport
        {
            class JdwpPacket;
        }
      }
    }
  }
}

class gnu::classpath::jdwp::transport::JdwpPacket : public ::java::lang::Object
{

public:
  JdwpPacket();
  JdwpPacket(::gnu::classpath::jdwp::transport::JdwpPacket *);
  virtual jint getId();
  virtual void setId(jint);
  virtual jbyte getFlags();
  virtual void setFlags(jbyte);
  virtual JArray< jbyte > * getData();
  virtual void setData(JArray< jbyte > *);
  virtual jint getLength();
public: // actually protected
  virtual jint myFromBytes(JArray< jbyte > *, jint) = 0;
public:
  static ::gnu::classpath::jdwp::transport::JdwpPacket * fromBytes(JArray< jbyte > *);
public: // actually protected
  virtual void myWrite(::java::io::DataOutputStream *) = 0;
public:
  virtual void write(::java::io::DataOutputStream *);
public: // actually protected
  static jint _last_id;
  static const jint JDWP_FLAG_REPLY = 128;
  static const jint MINIMUM_SIZE = 9;
  jint __attribute__((aligned(__alignof__( ::java::lang::Object)))) _id;
  jbyte _flags;
  JArray< jbyte > * _data;
public:
  static ::java::lang::Class class$;
};

#endif // __gnu_classpath_jdwp_transport_JdwpPacket__
