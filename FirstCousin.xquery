declare namespace functx = "http://www.functx.com";
declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";
declare option saxon:output "omit-xml-declaration=yes";
declare function functx:last-node 
  ( $nodes as node()* )  as node()? {
       
   ($nodes/.)[last()]
 } ;
 
 declare function functx:first-node 
  ( $nodes as node()* )  as node()? {
       
   ($nodes/.)[1]
 } ;

<html><head><title>First Cousins</title></head><body>
{

for $fam in doc("family1.xml")/GEDCOM/FamilyRec
let $maybeFirstChild := functx:first-node($fam/Child)
let $maybeSecondChild := functx:last-node($fam/Child)
for $fam2 in doc("family1.xml")/GEDCOM/FamilyRec
for $fam3 in doc("family1.xml")/GEDCOM/FamilyRec
let $isFamilyDecendantLeft := ($fam2/HusbFath/Link/@Ref = $maybeFirstChild/Link/@Ref or $fam2/WifeMoth/Link/@Ref = $maybeFirstChild/Link/@Ref)
let $isFamilyDecendantRight := ($fam3/HusbFath/Link/@Ref = $maybeSecondChild/Link/@Ref or $fam3/WifeMoth/Link/@Ref = $maybeSecondChild/Link/@Ref)
let $areNotTheSameChildren := $fam3/Child/Link/@Ref != $fam2/Child/Link/@Ref
where ( $isFamilyDecendantLeft and $isFamilyDecendantRight and $areNotTheSameChildren)
return (
<div>
<div class="CousinLeft">
{fn:string-join(//IndividualRec[@Id = ($fam2/Child/Link/@Ref)]/IndivName/text(),', ')}
</div>
<div class="CousinRight">
{fn:string-join(//IndividualRec[@Id = ($fam3/Child/Link/@Ref)]/IndivName/text(),', ')}
</div>
</div>
)
}
</body>
</html>