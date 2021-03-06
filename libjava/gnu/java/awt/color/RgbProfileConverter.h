
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __gnu_java_awt_color_RgbProfileConverter__
#define __gnu_java_awt_color_RgbProfileConverter__

#pragma interface

#include <java/lang/Object.h>
#include <gcj/array.h>

extern "Java"
{
  namespace gnu
  {
    namespace java
    {
      namespace awt
      {
        namespace color
        {
            class ColorLookUpTable;
            class RgbProfileConverter;
            class ToneReproductionCurve;
        }
      }
    }
  }
  namespace java
  {
    namespace awt
    {
      namespace color
      {
          class ICC_ProfileRGB;
      }
    }
  }
}

class gnu::java::awt::color::RgbProfileConverter : public ::java::lang::Object
{

public:
  RgbProfileConverter(::java::awt::color::ICC_ProfileRGB *);
  virtual JArray< jfloat > * toCIEXYZ(JArray< jfloat > *);
  virtual JArray< jfloat > * toRGB(JArray< jfloat > *);
  virtual JArray< jfloat > * fromCIEXYZ(JArray< jfloat > *);
  virtual JArray< jfloat > * fromRGB(JArray< jfloat > *);
private:
  JArray< JArray< jfloat > * > * invertMatrix(JArray< JArray< jfloat > * > *);
  JArray< JArray< jfloat > * > * __attribute__((aligned(__alignof__( ::java::lang::Object)))) matrix;
  JArray< JArray< jfloat > * > * inv_matrix;
  ::gnu::java::awt::color::ToneReproductionCurve * rTRC;
  ::gnu::java::awt::color::ToneReproductionCurve * gTRC;
  ::gnu::java::awt::color::ToneReproductionCurve * bTRC;
  ::gnu::java::awt::color::ColorLookUpTable * toPCS;
  ::gnu::java::awt::color::ColorLookUpTable * fromPCS;
  static JArray< jfloat > * D50;
public:
  static ::java::lang::Class class$;
};

#endif // __gnu_java_awt_color_RgbProfileConverter__
