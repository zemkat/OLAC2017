<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="marc xd xs"
    version="2.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 23, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Field Count</xd:p>
           <xd:p>Run this on a marc:collection file to list field names and their count as a text.</xd:p>          
        </xd:desc>
    </xd:doc>
      
    <xsl:output encoding="UTF-8" method="text"/>
    
    <xsl:template match="marc:collection">
        <xsl:for-each-group select=".//marc:controlfield" group-by="@tag">
            <xsl:sort select="@tag" order="ascending"/>
            <xsl:value-of select="concat(current-grouping-key(), ' ', count(current-group()), '&#xA;')"/>
        </xsl:for-each-group>
        <xsl:for-each-group select=".//marc:datafield" group-by="@tag">
            <xsl:sort select="@tag" order="ascending"/>
            <xsl:value-of select="concat(current-grouping-key(), ' ', count(current-group()), '&#xA;')"/>
        </xsl:for-each-group>
    </xsl:template>
   
</xsl:stylesheet>