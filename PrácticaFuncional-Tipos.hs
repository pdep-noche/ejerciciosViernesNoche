-- 1
p :: (a -> Bool) -> [ a ] ->  a
p n = (head . filter n)

-- 2
f :: (Ord a) => (b -> a )  ->  [(b , b)] ->  Bool
f x y = (x.fst.head) y > (x.snd.head) y

--3
g :: (Eq  t) => (s -> t) -> s -> s -> Bool
g f a b = f a == f b

-- 4
p1 :: (b -> Bool) -> (a -> b) -> Int -> [a] -> Bool  
p1 x y z = ((> z) . length . filter x . map y)

--5
h :: (Eq a) =>  a -> [(t , a , s)] -> (t, a, s)  
h nom  = head.filter ((nom==).g1)
g1 (_, c, _) = c

--6
f2 :: (Num a, Num b, Ord b) => a -> ( a -> b ) -> [a] -> a
f2 x _ [] = x
f2 x y (z:zs) | y z > 0 = z + f2 x y zs
              | otherwise = f2 x y zs

--7
f3 :: (Ord s)  =>  s -> (s -> h) -> [s] -> h
f3 a b (c:cs) | a > c = f3 a b cs
              | otherwise = b c

--8
f4 :: (Num s) => ( t ->  Bool) ->  h  -> [h] -> ( Int ->(s , Bool) -> t) -> Int ->  Int
f4 a b c d e  |(a . d e) (1, True) = 0
              | otherwise = length (b:c) + e

{-
f4 (>3) 'v' ['5','g'] const 2
=> 5

f4 (>3) 'v' ['5','g'] const 10
=> 0
-}

g2:: (Eq t) =>  (h -> t) -> t -> [h] -> h
g2 f x l = (head . filter ((x==).f)) l
{-
   g2 (+1) 5 [1..10]
=> 4
-}

qfsort :: (Ord s) =>  (a -> s ) -> [a]  -> [a]
qfsort f [ ] = [ ]
qfsort f (x:xs) = (qfsort f (filter ((> f x).f) xs)) ++ [x] ++ (qfsort f (filter ((< f x).f) xs))
{-
   qfsort (2*) [5,4,6,7,1,8]
=> [8,7,6,5,4,1]
   qfsort (1/) [5,4,6,7,1,8]
=> [1.0,4.0,5.0,6.0,7.0,8.0]
-}

floca :: (Num s) => ( t -> Bool ) -> (s -> t )  -> s -> [ s ]
floca g f n | (g . f ) n = n : floca g f (n + 1)
            | otherwise = floca g f (n + 1)