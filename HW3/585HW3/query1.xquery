xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Tue Nov 25 20:30:58 PST 2014 :)

<query1>
<ul>
{
for $work in doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor
let $div_deptid := doc("/Users/shuzizhang/585HW3/company.xml")/company/division[divid = $work/divid]/houseddeptid
let $dept_name := doc("/Users/shuzizhang/585HW3/company.xml")/company/department[deptid = $div_deptid]/deptname
let $emp_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/employee[empname = "PSmith" or empname = "Jack"]/empid
where $work/empid = $emp_id and $work/percenttime > 50
return  <li>{data($dept_name)}</li>
}
</ul>
</query1>
