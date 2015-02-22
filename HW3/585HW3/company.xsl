<?xml version="1.0" encoding="UTF-8" ?>

<!-- New XSLT document created with EditiX XML Editor (http://www.editix.com) at Sat Nov 29 11:35:58 PST 2014 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
	
		<html  xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Zishu 585HW3</title>
				<style type="text/css">
				</style>
			</head>
			<body>		
				<div id="1">
					<h1  style="color:red; font-size:24px; font-weight:bold; background-color:yellow; font-family:Arial;">Employee Information</h1>
					<xsl:for-each select="company/employee">
						<xsl:variable name="curempid" select="empid" />
						<p style="font-size:12px; font-family:Arial;" >
							Employee <b><xsl:value-of select="empname"/></b> 
							works from <b><xsl:value-of select="empoffice"/></b> office. 
							<b><xsl:value-of select="empname"/></b> works for 
							<b><xsl:value-of select="count(/company/worksfor[empid=$curempid])"/></b> divisions, 
							which are <xsl:variable name="curdivid" select="/company/worksfor[empid=$curempid]"/>
							<xsl:for-each select="$curdivid">
								<xsl:variable name="div_id" select="divid"/>
								<b><xsl:value-of select="/company/division[divid=$div_id]/divname"/></b>
								<xsl:if test="position() != last()">
									  <xsl:text>, </xsl:text>
								  </xsl:if>
								  <xsl:if test="position() = last() - 1">
									  <xsl:text>and </xsl:text>
								  </xsl:if>
							</xsl:for-each>. 
							
							<b><xsl:value-of select="empname"/></b>
							manages <b><xsl:value-of select="count(/company/division[managerempid=$curempid])"/></b> division(s),
							which are <xsl:variable name="m_divid" select="/company/division[managerempid=$curempid]"/>
							<xsl:for-each select="$m_divid">
								<xsl:variable name="di_ID" select="divid"/>
								<b><xsl:value-of select="/company/division[divid=$di_ID]/divname"/></b>
								<xsl:if test="position() != last()">
									  <xsl:text>, </xsl:text>
								  </xsl:if>
								  <xsl:if test="position() = last() - 1">
									  <xsl:text>and </xsl:text>
								  </xsl:if>
							</xsl:for-each>. 
							
							<b><xsl:value-of select="empname"/></b>
							 works for most time with the <xsl:variable name="percent_time" select="/company/worksfor[empid=$curempid]/percenttime"/>
							<xsl:for-each select="/company/worksfor[empid=$curempid]">
								<xsl:sort select="percenttime" data-type="number" order="ascending"/>
								<xsl:if test="position() = last()">
									<xsl:variable name="max_time_divId" select="divid"/>
									<xsl:variable name="max_time_divId_name" select="/company/division[divid=$max_time_divId]/divname"/>
									<b><xsl:value-of select="$max_time_divId_name"/></b>
									divison.
								</xsl:if>	  
							</xsl:for-each>
							</p>		 
					</xsl:for-each>
				</div>	
					
				<div id="2">
					<h1 style="color:red; font-size:24px; font-weight:bold; background-color:LightGreen; font-family:Arial;">Department Information</h1>
					<xsl:for-each select="company/department">
					<p style="font-size:12px; font-family:Arial;" >
						<xsl:variable name="Dep_Id" select="deptid" />
						<xsl:variable name="Dep_Name" select="deptname"/>
						Department <b><xsl:value-of select="$Dep_Name"/> </b>
						houses <b><xsl:value-of select="count(/company/division[houseddeptid=$Dep_Id])"/> </b> 
						division(s): <b>
										<xsl:variable name="div_name_table" select="/company/division[houseddeptid=$Dep_Id]"/>
										<xsl:for-each select="$div_name_table">
											  <xsl:variable name="div_name" select="divname"/>
											  <b><xsl:value-of select="$div_name"/></b>
											  <xsl:if test="position()!=last()">
												  <xsl:text>, </xsl:text>
											  </xsl:if>
											  <xsl:if test="position()=last()-1">
												  <xsl:text>and </xsl:text>
											  </xsl:if>
										</xsl:for-each>
						   			</b>
						</p>
					</xsl:for-each>	
				</div>
			</body>
		</html>
		
	</xsl:template>

</xsl:stylesheet>


