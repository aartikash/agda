{-# OPTIONS --cubical #-}
module Agda.Primitive.Cubical where
{-# BUILTIN INTERVAL I    #-} -- I : Setω

{-# BUILTIN IZERO    i0   #-}
{-# BUILTIN IONE     i1   #-}

infix 30 primINeg
infixr 20 primIMin primIMax

primitive
    primIMin : I → I → I
    primIMax : I → I → I
    primINeg : I → I

{-# BUILTIN ISONE        IsOne #-} -- IsOne : I → Setω


postulate
  itIsOne : IsOne i1
  IsOne1  : ∀ i j → IsOne i → IsOne (primIMax i j)
  IsOne2  : ∀ i j → IsOne j → IsOne (primIMax i j)

{-# BUILTIN ITISONE      itIsOne  #-}
{-# BUILTIN ISONE1       IsOne1   #-}
{-# BUILTIN ISONE2       IsOne2   #-}
{-# BUILTIN PARTIAL      Partial  #-}
{-# BUILTIN PARTIALP     PartialP #-}

postulate
  isOneEmpty : ∀ {a} {A : Partial (Set a) i0} → PartialP i0 A
{-# BUILTIN ISONEEMPTY isOneEmpty #-}

primitive
  primPFrom1 : ∀ {a} {A : I → Set a} → A i1 → ∀ i j → Partial (A (primIMax i j)) i
  primPOr : ∀ {a} (i j : I) {A : Partial (Set a) (primIMax i j)}
            → PartialP i (λ z → A (IsOne1 i j z)) → PartialP j (λ z → A (IsOne2 i j z))
            → PartialP (primIMax i j) A
  primComp : ∀ {a} (A : (i : I) → Set (a i)) (φ : I) → (∀ i → Partial (A i) φ) → (a : A i0) → A i1

syntax primPOr p q u t = [ p ↦ u , q ↦ t ]

primitive
  primTransp : ∀ {a} (A : (i : I) → Set (a i)) (φ : I) → (a : A i0) → A i1
  primHComp : ∀ {a} {A : Set a} {φ : I} → (∀ i → Partial A φ) → A → A
