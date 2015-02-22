xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Wed Nov 26 15:35:27 PST 2014 :)

<query3>
<ul>
{
let $emp_s := doc("/Users/shuzizhang/585HW3/company.xml")/company/employee[empname = "PSmith"]/empid
let $emp_w := doc("/Users/shuzizhang/585HW3/company.xml")/company/employee[empname = "Wong"]/empid
let $div_s := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[managerempid = $emp_s]/divid
let $div_w := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[managerempid = $emp_w]/divid
let $housed_id_s := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[divid = $div_s]/houseddeptid
let $housed_id_w := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[divid = $div_w]/houseddeptid
let $housed_id := distinct-values($housed_id_s[not(.=$housed_id_w)]) 
for $dep in doc("/Users/shuzizhang/585HW3/company.xml")/company/department
where $dep/deptid = $housed_id
return <li>{data($dep/deptname)}</li>
}
</ul>
</query3>
