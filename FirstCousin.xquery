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

<firstCousins>
{
for $fam in doc("family1.xml")/GEDCOM/FamilyRec
let $maybeFirstChild := functx:first-node($fam/Child)
let $maybeSecondChild := functx:last-node($fam/Child)
for $fam2 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam3 in doc("family1.xml")/GEDCOM/FamilyRec

where (($fam2/HusbFath/Link/@Ref = $maybeFirstChild/Link/@Ref or $fam2/WifeMoth/Link/@Ref = $maybeFirstChild/Link/@Ref) and ($fam3/HusbFath/Link/@Ref = $maybeSecondChild/Link/@Ref or $fam3/WifeMoth/Link/@Ref = $maybeSecondChild/Link/@Ref) and $fam3/Child/Link/@Ref != $fam2/Child/Link/@Ref)
return (
<CousinLeft>
{$fam2/Child/Link}
</CousinLeft>,
<CousinRight>
{$fam3/Child/Link}
</CousinRight>
)
}
</firstCousins>