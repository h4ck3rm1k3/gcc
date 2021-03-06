
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __java_util_concurrent_LinkedBlockingQueue__
#define __java_util_concurrent_LinkedBlockingQueue__

#pragma interface

#include <java/util/AbstractQueue.h>
#include <gcj/array.h>


class java::util::concurrent::LinkedBlockingQueue : public ::java::util::AbstractQueue
{

  void signalNotEmpty();
  void signalNotFull();
  void insert(::java::lang::Object *);
  ::java::lang::Object * extract();
  void fullyLock();
  void fullyUnlock();
public:
  LinkedBlockingQueue();
  LinkedBlockingQueue(jint);
  LinkedBlockingQueue(::java::util::Collection *);
  virtual jint size();
  virtual jint remainingCapacity();
  virtual void put(::java::lang::Object *);
  virtual jboolean offer(::java::lang::Object *, jlong, ::java::util::concurrent::TimeUnit *);
  virtual jboolean offer(::java::lang::Object *);
  virtual ::java::lang::Object * take();
  virtual ::java::lang::Object * poll(jlong, ::java::util::concurrent::TimeUnit *);
  virtual ::java::lang::Object * poll();
  virtual ::java::lang::Object * peek();
  virtual jboolean remove(::java::lang::Object *);
  virtual JArray< ::java::lang::Object * > * toArray();
  virtual JArray< ::java::lang::Object * > * toArray(JArray< ::java::lang::Object * > *);
  virtual ::java::lang::String * toString();
  virtual void clear();
  virtual jint drainTo(::java::util::Collection *);
  virtual jint drainTo(::java::util::Collection *, jint);
  virtual ::java::util::Iterator * iterator();
private:
  void writeObject(::java::io::ObjectOutputStream *);
  void readObject(::java::io::ObjectInputStream *);
public: // actually package-private
  static ::java::util::concurrent::locks::ReentrantLock * access$0(::java::util::concurrent::LinkedBlockingQueue *);
  static ::java::util::concurrent::locks::ReentrantLock * access$1(::java::util::concurrent::LinkedBlockingQueue *);
  static ::java::util::concurrent::LinkedBlockingQueue$Node * access$2(::java::util::concurrent::LinkedBlockingQueue *);
  static ::java::util::concurrent::LinkedBlockingQueue$Node * access$3(::java::util::concurrent::LinkedBlockingQueue *);
  static void access$4(::java::util::concurrent::LinkedBlockingQueue *, ::java::util::concurrent::LinkedBlockingQueue$Node *);
  static ::java::util::concurrent::atomic::AtomicInteger * access$5(::java::util::concurrent::LinkedBlockingQueue *);
  static jint access$6(::java::util::concurrent::LinkedBlockingQueue *);
  static ::java::util::concurrent::locks::Condition * access$7(::java::util::concurrent::LinkedBlockingQueue *);
private:
  static const jlong serialVersionUID = -6903933977591709194LL;
  jint __attribute__((aligned(__alignof__( ::java::util::AbstractQueue)))) capacity;
  ::java::util::concurrent::atomic::AtomicInteger * count;
  ::java::util::concurrent::LinkedBlockingQueue$Node * head;
  ::java::util::concurrent::LinkedBlockingQueue$Node * last;
  ::java::util::concurrent::locks::ReentrantLock * takeLock;
  ::java::util::concurrent::locks::Condition * notEmpty;
  ::java::util::concurrent::locks::ReentrantLock * putLock;
  ::java::util::concurrent::locks::Condition * notFull;
public: // actually package-private
  static jboolean $assertionsDisabled;
public:
  static ::java::lang::Class class$;
};

#endif // __java_util_concurrent_LinkedBlockingQueue__
