{-|
  Description : Inliner for graphs.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2011
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module provides inlining for value graphs.
-}
module MD.Inliner
    ( ToInline, inline )
where
import MD.Sharing

type ToInline = [(String,ValueGraph)]

inline :: ToInline -> ValueGraph -> ValueGraph
inline _ vg = vg
