<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="marc xd xs" version="2.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 23, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Edit Field</xd:p>
            <xd:p>Run this on a marc:collection file to overwrite the value of marc:subfield[@code='a'] if it starts-with a particular string.</xd:p>
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
    
    <!-- **Do not leave all of these template sections uncommented. See note in Documentation.** -->

    <!-- **Template 1. Conditional to add new text based on existing text.** -->
    
    <xsl:template match="//marc:subfield[@code='a'][starts-with(.,'(FTaSU)FS-DEGEN-2017')]">
                <marc:subfield code='a'>
                    <xsl:value-of select="
                    if (contains(.,'0901')) then 'Loaded September 1, 2017.' else
                    if (contains(.,'0906')) then 'Loaded September 6, 2017.' else
                    if (contains(.,'0919')) then 'Loaded September 19, 2017.' else
                    if (contains(.,'0925')) then 'Loaded September 19, 2017.' else 
                    ()"/></marc:subfield>          
    </xsl:template>
    
    <!-- **Template 2. Reformating a numerica date string into a Month Day, Year phrase using the XPath function format-date().** -->    
    
    <xsl:template match="//marc:subfield[@code='a'][starts-with(.,'(FTaSU)FS-DEGEN-2017')]">
        
        <!-- This variable outputs the YYYYMMDD portion of the string. -->
        <xsl:variable name="date_string" select="substring-after(.,'(FTaSU)FS-DEGEN-')"/>
        
        <!-- Since the $a text is always a consistent length, subtring() could also be used: -->
       <!-- <xsl:variable name="date_string" select="substring(.,17)"/>-->
        
        <!-- date-format() expects a date in w3cdtf, i.e. YYYY-MM-DD.
              The $w3cdtf_date variable concatonates substrings of the date_string separated with a dash. -->
        <xsl:variable name="w3cdtf_date" select="concat(substring($date_string,1,4),'-',substring($date_string,5,2),'-',substring($date_string,7,2))"/>
        
        <!-- xs:date converts the string to a date. -->
        <xsl:variable name="date" select="xs:date($w3cdtf_date)"/>
        
        <marc:subfield code='a'>
            
            <!-- **Hint: It is good practice to test the output of each variable before using it for another process. 
                 Comment and uncomment these string to test the variables.** -->
            <!--<xsl:value-of select="concat('Loaded ',$date_string,'.')"/> -->
            <!--<xsl:value-of select="concat('Loaded ',$w3cdtf_date,'.')"/>--> 
            <!--<xsl:value-of select="concat('Loaded ',$date,'.')"/>--> 
            
            <xsl:value-of select="concat('Loaded ',format-date($date,'[MNn] [D], [Y]'),'.')"/>
        </marc:subfield>          
    </xsl:template>

</xsl:stylesheet>
