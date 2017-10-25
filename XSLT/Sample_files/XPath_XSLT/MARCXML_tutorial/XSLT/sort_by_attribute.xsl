<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="marc xd xs" version="2.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 25, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Sort by Attribute</xd:p>
            <xd:p>Run this on a marc:collection file to sort each marc:record's fields by tag.</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>

    <!-- Generic identify template -->
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Sort by attribute -->
    
    <xsl:template match="marc:collection/marc:record">
        <xsl:copy>
            <xsl:apply-templates select="marc:leader"/>
            <xsl:apply-templates select="marc:controlfield">
                <xsl:sort select="@tag" order="ascending"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="marc:datafield">
                <xsl:sort select="@tag" order="ascending"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
