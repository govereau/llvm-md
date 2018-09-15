\ignore{
  Description : Denotational interpreter for value graphs.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010-2011
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module give an informal semantics for value graphs by providing an
  interpreter.

> {-# LANGUAGE MultiParamTypeClasses #-}
> module MD.DInterp
> where
> import Control.Monad
> import Control.Monad.Reader
> import Control.Monad.Writer
> import Control.Monad.State
> import Data.Monoid
> import Data.Either
> import qualified Data.IntMap as IM

> --import MD.Graph
> import MD.Syntax.GDSA
> import MD.Sharing

> import qualified Debug.Trace

}
\subsection{Monadic Structure}

> data Env = Env { valgr  :: ValueGraph
>                , params :: [(Ident,Result)]
>                , muu   :: Int
>                , muv   :: Result
>                }
> data St  = St  { results :: IM.IntMap Result
>                , lmem  :: Stack
>                , lastu :: Int
>                }
> data Tr  = Tr  { tr :: [Action] }

> data Result
>    = Rd Integer
>    | Fn Result [Result]
>    | C Const
>    | Stream [Result]
>      deriving (Eq)

> data Action = Wr Integer Result | FnCall Result [Result]

> instance Show Result where
>     show (C x) = show x
>     show (Stream l) = "S "++ show (head l)

> instance Num Result where
>     C (Int a) + C (Int b) = C (Int (a+b))

> instance Monoid Tr where
>     mempty      = Tr []
>     mappend x y = Tr $ tr x ++ tr y
>     mconcat l   = Tr (concatMap tr l)

> newtype M a = M { runM :: Env -> St -> (Tr,St,a) }

> logm m = M $ \_ s -> Debug.Trace.trace m (mempty,s, ())

> instance Monad M where
>     return x = M $ \_ s -> (mempty,s,x)
>     m >>= f  = M $ \e s -> let (t1,s1,v1) = runM m e s
>                                (t2,s2,v2) = runM (f v1) e s1
>                            in (mappend t1 t2, s2, v2)
>     fail msg = M $ \_ _ -> error msg

> instance MonadReader Env M where
>     ask       = M $ \e s -> (mempty, s, e)
>     local f m = M $ \e s -> runM m (f e) s

> instance MonadWriter Tr M where
>     tell a   = M $ \_ s -> (a, s, ())
>     listen m = M $ \e s -> let (t,s',v) = runM m e s
>                            in (t,s', (v,t))
>     pass m   = M $ \e s -> let (t,s',(v,f)) = runM m e s
>                            in (f t, s', v)

> instance MonadState St M where
>     get   = M $ \_ s -> (mempty, s, s)
>     put s = M $ \_ _ -> (mempty, s, ())

> trace :: Action -> M ()
> trace a = tell (Tr [a])

> getVG :: M ValueGraph
> getVG = asks valgr

> type Stack = [(Integer, (Type,Result))]

> stack :: M Stack
> stack = gets lmem

> putStack :: Stack -> M ()
> putStack st = modify $ \s -> s { lmem = st }

> fetch :: Int -> M Value
> fetch u = do { vg <- getVG
>              ; modify $ \s -> s { lastu = u }
>              ; return $ fetchVal vg u
>              }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\subsection{Entry Point}

> dinterp :: ValueGraph -> [(Ident, Result)] -> IO ()
> dinterp vg ps =
>     do { print vg
>        ; let (s,t,x) = runM function
>                        Env { valgr = vg
>                            , params = ps
>                            , muu = -1, muv = C Undef
>                            }
>                        St  { lmem = []
>                            , lastu = -1
>                            }
>        ; case x of
>            Stream (v:vs) -> print v
>            y -> print y
>        ; return ()
>        }

> toInt :: Result -> Integer
> toInt (C (Int i)) = i
> toInt _ = error "not int"

> deref :: Result -> [Integer] -> M Result
> deref _ _ = fail "deref"  -- look inside structure

> true :: Result -> Bool
> true (C (Int i)) = i /= 0
> true _ = False

ho do we handle memory and return value?
maybe do memory evaluation first, then compute the
return value?

> function :: M Result
> function =
>     do { vg <- getVG
>        ; let ~(CV (Returns(v,m))) = fetchVal vg (head $ findReturns vg)
>        ; term v
>        }

> term :: Int -> M Result
> term u =
>     do { e <- ask
>        ; t <- fetch u
>        ; logm (show u ++":"++ show t)
>        ; r <- if u == muu e then return (muv e)
>               else fetch u >>= term'
>        ; logm (show u ++":"++ show t ++ " --> "++ show r)
>        ; return r
>        }


> term' :: Value -> M Result
> term' (Param x) = do { ps <- asks params
>                      ; case lookup x ps of
>                          Nothing -> fail "unknow"
>                          Just v  -> return v --term' v
>                     }
> term' (CV v)    = val v

> add x y  = C $ Int (x + y)
> slt x y  = C $ Int (if x < y then 1 else 0)
> eq x y   = C $ Int (if x == y then 1 else 0)
> ne x y   = C $ Int (if x /= y then 1 else 0)
> srem x y = C $ Int (mod x y)

> sc f (C (Int x)) (C (Int y)) = f x y
> sc f (Stream l) (C (Int y)) = Stream $ map (\x -> sc f x (C $ Int y)) l
> sc f (C (Int y)) (Stream l) = Stream $ map (\x -> sc f (C $ Int y) x) l
> sc f (Stream x) (Stream y)  = Stream $ map (\(a,b) -> (sc f) a b) (zip x y)
> sc f x y = error ("sc " ++ show (x,y))

> val :: Common Int -> M Result
> val (Const c)  = return (C c)
> val (Proj _ x) = term x

basic expressions

> val (GetElemPtr ty t ts) =
>     do { v  <- term t
>        ; vs <- mapM term ts
>        ; deref v (map toInt vs)
>        }

> val (BinOp op s ty x y) =
>     do v1 <- term x
>        v2 <- term y
>        case op of
>          Bop Add  -> return $ sc add v1 v2
>          Bop SRem -> return $ sc srem v1 v2
>          Cmp SLT  -> return $ sc slt v1 v2
>          Cmp MD.Syntax.GDSA.EQ -> return $ sc eq v1 v2
>          Cmp NE   -> return $ sc ne  v1 v2
>          _ -> fail $ "("++show op++s++ show (ty, v1, v2) ++ ")"

> val (Conv _cop _t1 x _t2) = term x

> val (Select c x y) =
>     do cv <- term c
>        if true cv then term x else term y

> val (Extract ty a xs) =
>     do x <- term a
>        deref x xs

memory stuff

> val (Alloc ty sz _) =
>     do { s <- stack
>        ; let p = maximum (map fst s)
>        ; return (C Undef)
>        }

> val (Load ty p m) =
>    do { term m
>       ; x <- liftM toInt (term p)
>       ; s <- stack
>       ; case lookup x s of
>           Nothing -> return (Rd x)   -- gobal read
>           Just r  -> return (snd r)  -- check types ?
>       }

> val (Store ty p t m) =
>     do { term m
>        ; s <- stack
>        ; x <- liftM toInt (term p)
>        ; v <- term t
>        ; case lookup x s of
>            Nothing -> trace (Wr x v)  -- global write (need info)
>            Just r  -> putStack $ (x, (ty,v)) : s
>        ; return (C Undef)
>        }

> val (Call f xs m) =
>     do { term m
>        ; fv <- term f
>        ; vs <- mapM term xs
>        ; trace (FnCall fv vs)
>        ; return (Fn fv vs)
>        }

special node types

> val (Phi ty arms) = chk arms
>  where
>    chk [] = fail ("no true arms")
>    chk (PhiArm gs v:l) =
>        do { vs <- mapM term gs
>           ; if all true vs then term v else chk l
>           }

> val (Mu ty z s) =
>     do { u <- gets lastu
>        ; zt <- term z
>        ; ev <- ask
>        ; st <- get
>        ; return $ Stream (thr $ runM (next u zt s) ev st)
>        ; --zs <- next u zt s
>        ; --return $ Stream (zt:zs)
>        }
>  where
>   thr (_,_,x) = x
>   next u z s | Debug.Trace.trace ("mu "++ show (u,z,s)) True =
>       do { z' <- local (\e -> e { muu = u
>                                 , muv = z
>                                 }) (term s)
>          ; vs <- next u z' s
>          ; return (z:vs)
>          }


> val (Eta l1 l2) = do cs <- term l1
>                      vs <- term l2
>                      chk cs vs
>  where
>    chk (Stream (c:cs)) (Stream (v:vs))
>        | Debug.Trace.trace (show (c,v)) True =
>       if true c then return v
>       else chk (Stream cs) (Stream vs)
>    chk a b = fail ("Eta "++ show (a,b))

> val (Returns _) = fail "return found"
