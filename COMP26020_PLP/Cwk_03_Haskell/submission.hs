-- Representation
-- The default representation is by clockwise
--
-- 1  2
-- 4  3
data Colour = Black | White | Empty deriving (Eq, Show)
data Quadtree = Leaf Colour | Quad Quadtree Quadtree Quadtree Quadtree deriving (Eq, Show)

-- allBlack function
allBlack :: Int -> Quadtree
allBlack n = Leaf Black

-- allWhite function
allWhite :: Int -> Quadtree
allWhite n = Leaf White

-- clockwise function
clockwise :: Quadtree -> Quadtree -> Quadtree -> Quadtree -> Quadtree
clockwise = Quad

-- anticlockwise function
anticlockwise :: Quadtree -> Quadtree -> Quadtree -> Quadtree -> Quadtree
anticlockwise n1 n2 n3 n4 = Quad n1 n4 n3 n2

-- countNeighbours
countNeighbours :: Colour -> Colour -> Colour -> Colour -> Int
countNeighbours a b c d = 
    let 
        countColor Black = (1, 0)
        countColor White = (0, 1)
        countColor Empty = (0, 0)
        (aBlack, aWhite) = countColor a
        (bBlack, bWhite) = countColor b
        (cBlack, cWhite) = countColor c
        (dBlack, dWhite) = countColor d
    in (aBlack + bBlack + cBlack + dBlack) - (aWhite + bWhite + cWhite + dWhite)

-- determine colour
determineColour :: Int -> Colour -> Colour
determineColour count leaf
    | count > 0 = Black
    | count < 0 = White
    | count == 0 = leaf 

-- blur
blur :: Quadtree -> Quadtree
blur (Quad (Leaf nw) (Leaf ne) (Leaf se) (Leaf sw)) = 
    let
        -- calculate the neighbour diff
        bNW = countNeighbours ne sw ne sw
        bNE = countNeighbours nw se nw se
        bSE = countNeighbours ne sw ne sw
        bSW = countNeighbours nw se nw se
        
        -- determine the new colour
        newNW = determineColour bNW nw
        newNE = determineColour bNE ne
        newSE = determineColour bSE se
        newSW = determineColour bSW sw
    in Quad (Leaf newNW) (Leaf newNE) (Leaf newSE) (Leaf newSW)
blur (Quad (Quad (Leaf a) (Leaf b) (Leaf c) (Leaf d)) (Quad (Leaf e) (Leaf f) (Leaf g) (Leaf h)) (Quad (Leaf i) (Leaf j) (Leaf k) (Leaf l)) (Quad (Leaf m) (Leaf n) (Leaf o) (Leaf p))) =
    let
        -- determine the new colour
        aNew = determineColour (countNeighbours b d b d) a
        bNew = determineColour (countNeighbours a c e Empty) b
        cNew = determineColour (countNeighbours b d h n) c
        dNew = determineColour (countNeighbours a c m Empty) d
        eNew = determineColour (countNeighbours b h f Empty) e
        fNew = determineColour (countNeighbours a g e g) f
        gNew = determineColour (countNeighbours f h j Empty) g
        hNew = determineColour (countNeighbours c e g i) h
        iNew = determineColour (countNeighbours h n j l) i
        jNew = determineColour (countNeighbours g i k Empty) j
        kNew = determineColour (countNeighbours j l j l) k
        lNew = determineColour (countNeighbours l k i Empty) l
        mNew = determineColour (countNeighbours d n p Empty) m
        nNew = determineColour (countNeighbours c m o i) n
        oNew = determineColour (countNeighbours p n l Empty) o
        pNew = determineColour (countNeighbours m o m o) p
    in Quad (Quad (Leaf aNew) (Leaf bNew) (Leaf cNew) (Leaf dNew)) 
    (Quad (Leaf eNew) (Leaf fNew) (Leaf gNew) (Leaf hNew)) 
    (Quad (Leaf iNew) (Leaf jNew) (Leaf kNew) (Leaf lNew)) 
    (Quad (Leaf mNew) (Leaf nNew) (Leaf oNew) (Leaf pNew)) 
blur a = a