/* Helper function for cshift functions.
   Copyright 2008 Free Software Foundation, Inc.
   Contributed by Thomas Koenig <tkoenig@gcc.gnu.org>

This file is part of the GNU Fortran 95 runtime library (libgfortran).

Libgfortran is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

In addition to the permissions in the GNU General Public License, the
Free Software Foundation gives you unlimited permission to link the
compiled version of this file into combinations with other programs,
and to distribute those combinations without any restriction coming
from the use of this file.  (The General Public License restrictions
do apply in other respects; for example, they cover modification of
the file, and distribution when not linked into a combine
executable.)

Libgfortran is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public
License along with libgfortran; see the file COPYING.  If not,
write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
Boston, MA 02110-1301, USA.  */

#include "libgfortran.h"
#include <stdlib.h>
#include <assert.h>
#include <string.h>


#if defined (HAVE_GFC_COMPLEX_4)

void
cshift0_c4 (gfc_array_c4 *ret, const gfc_array_c4 *array, ssize_t shift,
		     int which)
{
  /* r.* indicates the return array.  */
  index_type rstride[GFC_MAX_DIMENSIONS];
  index_type rstride0;
  index_type roffset;
  GFC_COMPLEX_4 *rptr;

  /* s.* indicates the source array.  */
  index_type sstride[GFC_MAX_DIMENSIONS];
  index_type sstride0;
  index_type soffset;
  const GFC_COMPLEX_4 *sptr;

  index_type count[GFC_MAX_DIMENSIONS];
  index_type extent[GFC_MAX_DIMENSIONS];
  index_type dim;
  index_type len;
  index_type n;

  which = which - 1;
  sstride[0] = 0;
  rstride[0] = 0;

  extent[0] = 1;
  count[0] = 0;
  n = 0;
  /* Initialized for avoiding compiler warnings.  */
  roffset = 1;
  soffset = 1;
  len = 0;

  for (dim = 0; dim < GFC_DESCRIPTOR_RANK (array); dim++)
    {
      if (dim == which)
        {
          roffset = ret->dim[dim].stride;
          if (roffset == 0)
            roffset = 1;
          soffset = array->dim[dim].stride;
          if (soffset == 0)
            soffset = 1;
          len = array->dim[dim].ubound + 1 - array->dim[dim].lbound;
        }
      else
        {
          count[n] = 0;
          extent[n] = array->dim[dim].ubound + 1 - array->dim[dim].lbound;
          rstride[n] = ret->dim[dim].stride;
          sstride[n] = array->dim[dim].stride;
          n++;
        }
    }
  if (sstride[0] == 0)
    sstride[0] = 1;
  if (rstride[0] == 0)
    rstride[0] = 1;

  dim = GFC_DESCRIPTOR_RANK (array);
  rstride0 = rstride[0];
  sstride0 = sstride[0];
  rptr = ret->data;
  sptr = array->data;

  shift = len == 0 ? 0 : shift % (ssize_t)len;
  if (shift < 0)
    shift += len;

  while (rptr)
    {
      /* Do the shift for this dimension.  */

      /* If elements are contiguous, perform the operation
	 in two block moves.  */
      if (soffset == 1 && roffset == 1)
	{
	  size_t len1 = shift * sizeof (GFC_COMPLEX_4);
	  size_t len2 = (len - shift) * sizeof (GFC_COMPLEX_4);
	  memcpy (rptr, sptr + shift, len2);
	  memcpy (rptr + (len - shift), sptr, len1);
	}
      else
	{
	  /* Otherwise, we will have to perform the copy one element at
	     a time.  */
	  GFC_COMPLEX_4 *dest = rptr;
	  const GFC_COMPLEX_4 *src = &sptr[shift * soffset];

	  for (n = 0; n < len - shift; n++)
	    {
	      *dest = *src;
	      dest += roffset;
	      src += soffset;
	    }
	  for (src = sptr, n = 0; n < shift; n++)
	    {
	      *dest = *src;
	      dest += roffset;
	      src += soffset;
	    }
	}

      /* Advance to the next section.  */
      rptr += rstride0;
      sptr += sstride0;
      count[0]++;
      n = 0;
      while (count[n] == extent[n])
        {
          /* When we get to the end of a dimension, reset it and increment
             the next dimension.  */
          count[n] = 0;
          /* We could precalculate these products, but this is a less
             frequently used path so probably not worth it.  */
          rptr -= rstride[n] * extent[n];
          sptr -= sstride[n] * extent[n];
          n++;
          if (n >= dim - 1)
            {
              /* Break out of the loop.  */
              rptr = NULL;
              break;
            }
          else
            {
              count[n]++;
              rptr += rstride[n];
              sptr += sstride[n];
            }
        }
    }

  return;
}

#endif
