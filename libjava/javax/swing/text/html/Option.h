
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __javax_swing_text_html_Option__
#define __javax_swing_text_html_Option__

#pragma interface

#include <java/lang/Object.h>
extern "Java"
{
  namespace javax
  {
    namespace swing
    {
      namespace text
      {
          class AttributeSet;
        namespace html
        {
            class Option;
        }
      }
    }
  }
}

class javax::swing::text::html::Option : public ::java::lang::Object
{

public:
  Option(::javax::swing::text::AttributeSet *);
  virtual void setLabel(::java::lang::String *);
  virtual ::java::lang::String * getLabel();
  virtual ::javax::swing::text::AttributeSet * getAttributes();
  virtual ::java::lang::String * toString();
public: // actually protected
  virtual void setSelection(jboolean);
public:
  virtual jboolean isSelected();
  virtual ::java::lang::String * getValue();
private:
  ::javax::swing::text::AttributeSet * __attribute__((aligned(__alignof__( ::java::lang::Object)))) attributes;
  ::java::lang::String * label;
  jboolean selected;
public:
  static ::java::lang::Class class$;
};

#endif // __javax_swing_text_html_Option__
