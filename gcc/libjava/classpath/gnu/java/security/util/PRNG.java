/* PRNG.java -- A Utility methods for default source of randomness
   Copyright (C) 2006 Free Software Foundation, Inc.

This file is part of GNU Classpath.

GNU Classpath is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GNU Classpath is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Classpath; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA.

Linking this library statically or dynamically with other modules is
making a combined work based on this library.  Thus, the terms and
conditions of the GNU General Public License cover the whole
combination.

As a special exception, the copyright holders of this library give you
permission to link this library with independent modules to produce an
executable, regardless of the license terms of these independent
modules, and to copy and distribute the resulting executable under
terms of your choice, provided that you also meet, for each linked
independent module, the terms and conditions of the license of that
module.  An independent module is a module which is not derived from
or based on this library.  If you modify this library, you may extend
this exception to your version of the library, but you are not
obligated to do so.  If you do not wish to do so, delete this
exception statement from your version. */


package gnu.java.security.util;

import java.util.HashMap;

import gnu.java.security.prng.IRandom;
import gnu.java.security.prng.LimitReachedException;
import gnu.java.security.prng.MDGenerator;

/**
 * A useful hash-based (SHA) pseudo-random number generator used throughout this
 * library.
 * 
 * @see MDGenerator
 */
public class PRNG
{
  /** The underlying {@link IRandom}. */
  private IRandom delegate;

  /**
   * Private constructor to enforce using the Factory method.
   * 
   * @param delegate the undelying {@link IRandom} object used.
   */
  private PRNG(IRandom delegate)
  {
    super();

    this.delegate = delegate;
  }

  public static final PRNG getInstance()
  {
    IRandom delegate = new MDGenerator();
    try
      {
        HashMap map = new HashMap();
        // initialise it with a seed
        long t = System.currentTimeMillis();
        byte[] seed = new byte[] {
            (byte)(t >>> 56), (byte)(t >>> 48),
            (byte)(t >>> 40), (byte)(t >>> 32),
            (byte)(t >>> 24), (byte)(t >>> 16),
            (byte)(t >>>  8), (byte) t };
        map.put(MDGenerator.SEEED, seed);
        delegate.init(map); // default is to use SHA-1 hash
      }
    catch (Exception x)
      {
        throw new ExceptionInInitializerError(x);
      }
    return new PRNG(delegate);
  }

  /**
   * Completely fills the designated <code>buffer</code> with random data
   * generated by the underlying delegate.
   * 
   * @param buffer the place holder of random bytes generated by the underlying
   *          delegate. On output, the contents of <code>buffer</code> are
   *          replaced with pseudo-random data, iff the <code>buffer</code>
   *          size is not zero.
   */
  public void nextBytes(byte[] buffer)
  {
    nextBytes(buffer, 0, buffer.length);
  }

  /**
   * Fills the designated <code>buffer</code>, starting from byte at position
   * <code>offset</code> with, at most, <code>length</code> bytes of random
   * data generated by the underlying delegate.
   * 
   * @see IRandom#nextBytes
   */
  public void nextBytes(byte[] buffer, int offset, int length)
  {
    try
      {
        delegate.nextBytes(buffer, offset, length);
      }
    catch (LimitReachedException x) // re-initialise with a seed
      {
        try
          {
            HashMap map = new HashMap();
            long t = System.currentTimeMillis();
            byte[] seed = new byte[] {
                (byte)(t >>> 56), (byte)(t >>> 48),
                (byte)(t >>> 40), (byte)(t >>> 32),
                (byte)(t >>> 24), (byte)(t >>> 16),
                (byte)(t >>>  8), (byte) t };
            map.put(MDGenerator.SEEED, seed);
            delegate.init(map); // default is to use SHA-1 hash
            delegate.nextBytes(buffer, offset, length);
          }
        catch (Exception y)
          {
            throw new ExceptionInInitializerError(y);
          }
      }
  }
}
