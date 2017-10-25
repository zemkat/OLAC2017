<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="marc xd xs" version="2.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 23, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Delete Fields</xd:p>
            <xd:p>Run this on a marc:collection file to delete OWN fields.</xd:p>
            <xd:p>Comment out all but one of the template sections below before running the transformation.</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <!-- Strip-space deletes the spaces left by deleted fields -->
    <xsl:strip-space elements="*"/>

    <!-- Generic identify template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- **Do not leave all of these template sections uncommented. See note in Documentation.**-->

    <!-- **Templates 1 & 2. Deletes all FMT and OWN Fields** -->

    <xsl:template match="/marc:collection/marc:record/marc:datafield[@tag = 'FMT']"/>
    <xsl:template match="/marc:collection/marc:record/marc:datafield[@tag = 'OWN']"/>

    <!-- **Template 3. Deletes all TKR Fields that do not have subfields.** -->

    <xsl:template match="/marc:collection/marc:record/marc:datafield[@tag = 'TKR'][not(marc:subfield)]"/>

    <!-- **Template 4. Deletes all TKR fields whose text does not start with "(FTaSU)".** -->

    <xsl:template match="/marc:collection/marc:record/marc:datafield[@tag = 'TKR'][not(starts-with(., '(FTaSU)'))]"/>

    <!-- **Template 5. Deletes all fields with alpha tags.** -->
    
    <xsl:template match="/marc:collection/marc:record/marc:datafield[matches(@tag, '[A-Z]')]"/>

</xsl:stylesheet>
