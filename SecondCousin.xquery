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
let $isFamilyDecendantLeft := ($fam2/HusbFath/Link/@Ref = $maybeFirstChild/Link/@Ref or $fam2/WifeMoth/Link/@Ref = $maybeFirstChild/Link/@Ref)
let $isFamilyDecendantRight := ($fam3/HusbFath/Link/@Ref = $maybeSecondChild/Link/@Ref or $fam3/WifeMoth/Link/@Ref = $maybeSecondChild/Link/@Ref)
let $isFamily2ndDecendantLeft := ($fam4/HusbFath/Link/@Ref = $fam2/Child/Link/@Ref or $fam4/WifeMoth/Link/@Ref = $fam2/Child/Link/@Ref) and $isFamilyDecendantLeft
let $isFamily2ndDecendantRight := ($fam5/HusbFath/Link/@Ref = $fam3/Child/Link/@Ref or $fam5/WifeMoth/Link/@Ref = $fam3/Child/Link/@Ref) and $isFamilyDecendantRight
let $areNotTheSameChildren := $fam4/Child/Link/@Ref != $fam5/Child/Link/@Ref
where ( $isFamily2ndDecendantLeft and $isFamily2ndDecendantRight and $areNotTheSameChildren)
return (
<CousinLeft>
{$fam4/Child/Link}
</CousinLeft>,
<CousinRight>
{$fam5/Child/Link}
</CousinRight>
)
}
</secondCousins>