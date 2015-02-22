xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Tue Nov 25 20:30:58 PST 2014 :)
<query2>
<ul>
{
let $x1 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "1"]/divid
let $x2 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "2"]/divid
let $x3 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "3"]/divid
let $x4 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "4"]/divid
let $x5 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "5"]/divid
let $x6 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "6"]/divid
let $x7 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "7"]/divid
let $x8 := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor[empid = "8"]/divid
for $everyemp in distinct-values ((((((($x1[.=$x2])[.=$x3])[.=$x4])[.=$x5])[.=$x6])[.=$x7])[.=$x8])
let $div_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[divid = $everyemp]
return <li>{data($div_id/divname)}</li>
}
</ul>
</query2>
