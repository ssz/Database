<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:template match="/">
		<html>
		<header>
			<h1>
				<strong>Employee Information</strong>
				<style type="text/css">
					h1{
							font-size: 24px;
							color: #FF0000;
							background-color: #FFFF00;
					}
				</style>
			</h1>
		</header>
		<body>
				<p>
					<xsl:for-each select="company/Employee">
					<xsl:variable name="curEmpId" select="empId" />
					<p>
							 Employee <strong><xsl:value-of select="empName"/></strong> 
							 works from <strong><xsl:value-of select="empOffice"/></strong> office. 
							 <strong><xsl:value-of select="empName"/></strong> works for 
							 <strong><xsl:value-of select="count(/company/WorksFor[empId=$curEmpId])"/></strong> divisions, 
							 which are
							 <xsl:variable name="curDivId" select="/company/WorksFor[empId=$curEmpId]"/>
			 
							 <xsl:for-each select="$curDivId">
								  <xsl:variable name="div_ID" select="divId"/>
								  <strong><xsl:value-of select="/company/Division[divId=$div_ID]/divName"/></strong>
								  <xsl:if test="position()!=last()">
									  <xsl:text>, </xsl:text>
								  </xsl:if>
								  <xsl:if test="position()=last()-1">
									  <xsl:text>and </xsl:text>
								  </xsl:if>
							 </xsl:for-each>. 
							 <strong><xsl:value-of select="empName"/></strong> works for most time with the 
							  
							 <xsl:variable name="percent_Time" select="/company/WorksFor[empId=$curEmpId]/percentTime"/>
							 <xsl:for-each select="/company/WorksFor[empId=$curEmpId]">
								  <xsl:sort select="percentTime" data-type="number" order="ascending"/>
										<xsl:if test="position() = last()">
												<xsl:variable name="max_time_divId" select="divId"/>
												<xsl:variable name="max_time_divId_name" select="/company/Division[divId=$max_time_divId]/divName"/>
												<strong><xsl:value-of select="$max_time_divId_name"/></strong>
												divison.
										</xsl:if>	  
							 </xsl:for-each>			 
					</p>
					</xsl:for-each>
				</p>

			
			<style type="text/css">

				body,td,th {
				font-family: Arial;
				font-size: 12px;
			}
			</style>
			
		</body>	
		<header> 	
			<h2>
				<strong>Department Information</strong>
				<style type="text/css">
					h2{
							font-size: 24px;
							color: #FF0000;
							background-color: #90EE90;
					}
				</style>
			</h2>
		</header>
		<body>
		<p>
			<xsl:for-each select="company/Department">
				<xsl:variable name="Dep_Id" select="deptId" />
				<xsl:variable name="Dep_Name" select="deptName"/>
				<p>
					Department <strong><xsl:value-of select="$Dep_Name"/> </strong>
					houses <strong>
									<xsl:value-of select="count(/company/Division[housedDeptId=$Dep_Id])"/> 
						   </strong> division(s): 
						   <strong>
									<xsl:variable name="div_name_table" select="/company/Division[housedDeptId=$Dep_Id]"/>
									<xsl:for-each select="$div_name_table">
										  <xsl:variable name="div_name" select="divName"/>
										  <strong><xsl:value-of select="$div_name"/></strong>
										  <xsl:if test="position()!=last()">
											  <xsl:text>, </xsl:text>
										  </xsl:if>
										  <xsl:if test="position()=last()-1">
											  <xsl:text>and </xsl:text>
										  </xsl:if>
									</xsl:for-each>
						   </strong>
						   
				</p>
			</xsl:for-each>
		</p>
		
		<style type="text/css">

				body,td,th {
				font-family: Arial;
				font-size: 12px;
			}
			</style>
		</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>
