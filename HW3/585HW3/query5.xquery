xquery version "1.0";

(: Generated with EditiX XML Editor (http://www.editix.com) at Wed Nov 26 16:34:49 PST 2014 :)

<query5>
<ul>
{
let $num_divid := 
		let  $emp_id := doc("/Users/shuzizhang/585HW3/company.xml")/company/worksfor/empid
		return
			for $uniqueID in distinct-values($emp_id)
			return count($emp_id[.=$uniqueID])

let $average := avg($num_divid)

return <li>{data($average)}</li>
}
</ul>
</query5>
