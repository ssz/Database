xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Tue Nov 25 23:19:40 PST 2014 :)

<query6>
<ul>
{
	let $num_divid := 
		let  $emp_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor/empid
		return
			for $uniqueID in distinct-values($emp_id)
			return count($emp_id[.=$uniqueID])
			
	let $max_divid := max($num_divid)		
	
	let $max_empid := 
		let  $emp_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor/empid
		return
			for $uniqueID in distinct-values($emp_id)
			where count($emp_id[.=$uniqueID]) = $max_divid
			return $uniqueID
	
	for $employee in doc("/Users/shuzizhang/585HW3/company.xml")/company/employee
	where $employee/empid = $max_empid
	return <li>{data($employee/empname)}</li>
	

}
</ul>
</query6>
