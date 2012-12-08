<firstCousins>
{
for $fam in doc("family1.xml")/GEDCOM/FamilyRec
for $childID in $fam/Child/Link/@Ref
for $fam2 in doc("family1.xml")/GEDCOM/FamilyRec

where ($fam2/HusbFath/Link/@Ref = $childID)
or ($fam2/WifeMoth/Link/@Ref = $childID)

return <res>{$fam2/Child/Link/@Ref}</res>
}
</firstCousins>