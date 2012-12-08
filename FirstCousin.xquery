<firstCousins>
{
for $fam in doc("family1.xml")/GEDCOM/FamilyRec
for $childID in doc("family1.xml")/GEDCOM/FamilyRec/Child/Link/@Ref

where ($fam/HusbFath/Link/@Ref = $childID)
or ($fam/WifeMoth/Link/@Ref = $childID)

return <res>{$fam/Child/Link/@Ref}</res>
}
</firstCousins>