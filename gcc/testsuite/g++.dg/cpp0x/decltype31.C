// PR c++/49921
// { dg-options -std=c++0x }

struct Local
{
  void f();
};

Local *l;
void (Local::*ptr)();
decltype((l->*ptr)) i;	       // { dg-error "member function" }

// { dg-prune-output "invalid type in declaration" }
