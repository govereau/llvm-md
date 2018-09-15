{-# LANGUAGE PatternGuards #-}
{-|
  Description : Simple loop detection.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  A simple filter to rule out control flow we do not handle.
-}
module MD.LoopDetection ( ld ) where
import Control.Monad
import Data.List
import MD.Syntax.GDSA
import MD.Graph

ld :: Monad m => [GBlock] -> m [GBlock]
ld bs = cycles bs >>= chk_rets

chk_rets :: Monad m => [GBlock] -> m [GBlock]
chk_rets bs = if length rbs == 1 then return bs
              else fail "multiple function returns"
 where
   rbs = fst $ partition isReturn bs
   isReturn b = case control b of { Ret _ -> True; _ -> False }

cycles :: Monad m => [GBlock] -> m [GBlock]
cycles bs = chk_scc (gscc bs)
 where
   chk_scc []               = return []
   chk_scc (AcyclicSCC b:l) = liftM  (b:) (chk_scc l)
   chk_scc (CyclicSCC cs:l) = liftM2 (++) (chkCycle cs) (chk_scc l)

chkCycle :: Monad m => [GBlock] -> m [GBlock]
chkCycle yy =
    case partition pre_in yy of
      (bs,[x]) -> do { en <- case cfgpre x of
                               [a,b] | a `elem` qs -> return b
                                     | b `elem` qs -> return a
                                     | otherwise   -> fail "loop header is strange"
                               l -> fail ("header has " ++ show (length l) ++ " in edges")
                     ; bs' <- cycles bs
                     ; return $ x { loopHeader = Just (en,qs) } : bs'
                     }
      (_,l') -> fail ("Loop has " ++ show (length l') ++ " entries")
 where
   qs       = map label yy
   pre_in n = all (`elem` qs) (cfgpre n)
