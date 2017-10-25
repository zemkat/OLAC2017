<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="marc xd xs" version="2.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 23, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Add Field</xd:p>
            <xd:p>Run this on a marc:collection file to add a 590 field.</xd:p>
            <xd:p>Comment out all but one of the template sections below before running the transformation.</xd:p>            
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>

    <!-- Generic identify template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- **Do not leave all of these template sections uncommented. See note in Documentation.**-->

    <!-- **Template 1. Adds the field at the bottom of the record.** -->
    
    <xsl:template match="/marc:collection/marc:record">
        <marc:record>
            <xsl:copy-of select="*"/>
            <marc:datafield tag="590" ind1=" " ind2=" ">
                <marc:subfield code="a">A new field was added as the last element of the record.</marc:subfield>
            </marc:datafield>
        </marc:record>
    </xsl:template>

    <!-- **Template 2. Adds the field in before the first 590.** -->
    
    <xsl:template match="/*/*/marc:datafield[@tag = '590'][last()]">
        <marc:datafield tag="590" ind1=" " ind2=" ">
            <marc:subfield code="a">A new field was added before the last 590 field.</marc:subfield>
        </marc:datafield>
        <xsl:copy-of select="."/>
    </xsl:template>

</xsl:stylesheet>
