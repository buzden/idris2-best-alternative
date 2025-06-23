module Data.Alternative

%default total

-------------------------------
--- `Alternative` utilities ---
-------------------------------

public export %inline
atLeast : Alternative f => a -> f a -> f a
atLeast v = (<|> pure v)

public export %inline
optional : Alternative f => f a -> f (Maybe a)
optional = atLeast Nothing . map Just

-- `whenT b x` ~ `guard b $> x`
public export
whenT : Alternative f => Bool -> Lazy a -> f a
whenT True  x = pure x
whenT False _ = empty

public export
whenTs : Alternative f => Bool -> f a -> f a
whenTs True  x = x
whenTs False _ = empty

public export
whenJ : Alternative f => Maybe a -> (a -> b) -> f b
whenJ Nothing  _ = empty
whenJ (Just x) g = pure $ g x

public export
whenJs : Alternative f => Maybe a -> (a -> f b) -> f b
whenJs Nothing  _ = empty
whenJs (Just x) g = g x

public export
foldAlt : Alternative f => (a -> f b) -> List a -> f b
foldAlt _ []      = empty
foldAlt f (x::xs) = f x <|> foldAlt f xs

public export %inline
foldAlt' : Alternative f => List a -> (a -> f b) -> f b
foldAlt' = flip foldAlt
