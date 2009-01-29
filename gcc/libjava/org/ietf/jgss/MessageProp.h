
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __org_ietf_jgss_MessageProp__
#define __org_ietf_jgss_MessageProp__

#pragma interface

#include <java/lang/Object.h>
extern "Java"
{
  namespace org
  {
    namespace ietf
    {
      namespace jgss
      {
          class MessageProp;
      }
    }
  }
}

class org::ietf::jgss::MessageProp : public ::java::lang::Object
{

public:
  MessageProp(jboolean);
  MessageProp(jint, jboolean);
  virtual jint getQOP();
  virtual jboolean getPrivacy();
  virtual jint getMinorStatus();
  virtual ::java::lang::String * getMinorString();
  virtual void setQOP(jint);
  virtual void setPrivacy(jboolean);
  virtual jboolean isDuplicateToken();
  virtual jboolean isOldToken();
  virtual jboolean isUnseqToken();
  virtual jboolean isGapToken();
  virtual void setSupplementaryStates(jboolean, jboolean, jboolean, jboolean, jint, ::java::lang::String *);
private:
  jint __attribute__((aligned(__alignof__( ::java::lang::Object)))) qopVal;
  jboolean privState;
  jboolean duplicate;
  jboolean old;
  jboolean unseq;
  jboolean gap;
  jint minorStatus;
  ::java::lang::String * minorString;
public:
  static ::java::lang::Class class$;
};

#endif // __org_ietf_jgss_MessageProp__
