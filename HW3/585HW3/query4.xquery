xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Wed Nov 26 15:57:11 PST 2014 :)

<query4>
<ul>
{
let $ma_emp_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/division/managerempid
let $ma_emp_all := doc("/Users/shuzizhang/585HW3/company.xml")/company/employee/empid
let $m_e_id := distinct-values($ma_emp_all[not(.=$ma_emp_id)])
for $emp in doc("/Users/shuzizhang/585HW3/company.xml")/company/employee
where $emp/empid = $m_e_id
order by $emp/empname descending 
return <li>{data($emp/empname)}</li>
}
</ul>
</query4>
