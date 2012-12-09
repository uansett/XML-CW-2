declare namespace functx = "http://www.functx.com";
declare variable $potentialCousin1 := ();
declare variable $potentialCousin2 := ();
declare function functx:last-node 
  ( $nodes as node()* )  as node()? {
       
   ($nodes/.)[last()]
 } ;
 
 declare function functx:first-node 
  ( $nodes as node()* )  as node()? {
       
   ($nodes/.)[1]
 } ;

<secondCousins>
{
for $fam in doc("family1.xml")/GEDCOM/FamilyRec
let $maybeFirstChild := functx:first-node($fam/Child)
let $maybeSecondChild := functx:last-node($fam/Child)
for $fam2 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam3 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam4 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam5 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam6 in doc("family1.xml")/GEDCOM/FamilyRec
let $isFamilyDecendantLeft := ($fam4/HusbFath/Link/@Ref = $fam2/Child/Link/@Ref or $fam4/WifeMoth/Link/@Ref = $fam2/Child/Link/@Ref) and ($fam2/HusbFath/Link/@Ref = $maybeFirstChild/Link/@Ref or $fam2/WifeMoth/Link/@Ref = $maybeFirstChild/Link/@Ref)
let $isFamilyDecendantRight := ($fam5/HusbFath/Link/@Ref = $fam3/Child/Link/@Ref or $fam5/WifeMoth/Link/@Ref = $fam3/Child/Link/@Ref) and ($fam3/HusbFath/Link/@Ref = $maybeSecondChild/Link/@Ref or $fam3/WifeMoth/Link/@Ref = $maybeSecondChild/Link/@Ref)
let $isOnceRemovedLeft := ($fam6/HusbFath/Link/@Ref = $fam4/Child/Link/@Ref or $fam6/WifeMoth/Link/@Ref = $fam4/Child/Link/@Ref) and $isFamilyDecendantLeft
let $isOnceRemovedRight := ($fam6/HusbFath/Link/@Ref = $fam3/Child/Link/@Ref or $fam6/WifeMoth/Link/@Ref = $fam3/Child/Link/@Ref) and $isFamilyDecendantRight
let $areNotTheSameChildren := $fam3/Child/Link/@Ref != $fam2/Child/Link/@Ref
where ( $isFamilyDecendantLeft and $isFamilyDecendantRight and $areNotTheSameChildren and ($isOnceRemovedLeft ne $isOnceRemovedRight))
return (
<CousinLeft>
{if($isOnceRemovedLeft) then $fam6/Child/Link else ($fam4/Child/Link)}
</CousinLeft>,
<CousinRight>
{if($isOnceRemovedRight) then $fam6/Child/Link else($fam5/Child/Link)}
</CousinRight>
)
}
</secondCousins>