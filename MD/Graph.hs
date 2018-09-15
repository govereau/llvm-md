{-|
  Description : 'Data.Graph' with a few extra functions.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Interface to 'Data.Graph' with a few extra functions.
-}
module MD.Graph
  ( module Data.Graph
  , module MD.Graph
  )
where
import Data.Array
import Data.Graph
import Data.Tree
import MD.Syntax.GDSA

-- | Successors of a node

suc :: Graph -> Vertex -> [Vertex]
suc g v = g ! v

-- | Predecessors of a node

pre :: Graph -> Vertex -> [Vertex]
pre g v = [ x | (x,v') <- edges g, v == v' ]

-- | Graph printing

showGraph :: Graph -> String
showGraph g = drawForest (map (fmap show) (components g))

-- | Strongly Connected Components for GBlocks

gscc :: [GBlock] -> [SCC GBlock]
gscc bs = stronglyConnComp [ (v, label v, cfgsuc v) | v <- bs ]

-- | Topological sort of GBlocks

topsortBlocks :: [GBlock] -> [GBlock]
topsortBlocks bs = map proj (topSort gr)
 where
   (gr,vf) = graphFromEdges' [ (b, label b, cfgsuc b) | b <- bs ]
   proj x  = case vf x of (a,_,_) -> a

-- | Post-order of blocks

postorderBlocks :: [GBlock] -> [GBlock]
postorderBlocks = reverse . topsortBlocks

-- | Depth First ordering

dfoBlocks :: [GBlock] -> [GBlock]
dfoBlocks bs = map proj (reachable gr 0)
 where
   (gr,vf) = graphFromEdges' [ (b, label b, cfgsuc b) | b <- bs ]
   proj x  = case vf x of (a,_,_) -> a


-- | Toplogical sort of rules

topsortRules :: [RR] -> [RR]
topsortRules rr = map proj (topSort gr)
 where
   (gr,vf) = graphFromEdges' [ (r, rrIdent r, fvs (rrTerm r)) | r <- rr ]
   proj x  = case vf x of (a,_,_) -> a

-- | Post-order for rules

postorderRules ::[RR] -> [RR]
postorderRules = reverse . topsortRules -- postOrd not exported from Data.Graph

