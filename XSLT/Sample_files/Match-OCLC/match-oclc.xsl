<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="marc xd xs" version="2.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last updated: </xd:b>October 25, 2017</xd:p>
            <xd:p><xd:b>Author: </xd:b>Annie Glerum</xd:p>
            <xd:p><xd:b>Organization: </xd:b>Florida State University</xd:p>
            <xd:p><xd:b>Title: </xd:b>Match OCLC</xd:p>
            <xd:p>Run this on sirsi.xml to match output oclc records if the oclc.xml marc:datafield[@tag = '990']/marc:subfield[@code = 'a'] matches the sirsi.xml marc:datafield[@tag = '990']/marc:subfield[@code = 'a'].</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
        
    <!-- This variable references a another XML document then sets its current node to marc:collection/marc:record. -->
    <xsl:variable name="oclc" select="doc('XML/oclc.xml')/marc:collection/marc:record"/>
    
    <xsl:template match="/marc:collection">
        <marc:collection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:marc="http://www.loc.gov/MARC21/slim"
            xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
            
            <!-- This sets the current node. -->
            <xsl:for-each select="marc:record">
                
                <!-- This variable outputs a specific 049 holdings code depending on whether a format code in the 999 field is AV or not. -->
                <xsl:variable name="hol_049" select="if (marc:datafield[@tag = '999'][1]/marc:subfield[@code = 't'] != 'AV') then 'FSDGG' else 'FSDGM'"/>
                        <marc:record>
                            
                            <!-- This xsl:choose conditional outputs a record from oclc.xml if the number in the 990 $a fields match. 
                                 Otherwise, the sirsi.xml record is output.-->
                            
                            <xsl:choose>
                                <!-- When the 990 $a of oclc.xml is the same as the 990 $a of the current node... -->
                                <xsl:when
                                    test="$oclc[marc:datafield[@tag = '990']/marc:subfield[@code = 'a'] = current()/marc:datafield[@tag = '990']/marc:subfield[@code = 'a']]">
                                    
                                    <!-- ...then select the parent of the oclc.xml 990, marc:record, and all of its elements. --> 
                                    <xsl:copy-of select="$oclc[marc:datafield[@tag = '990']/marc:subfield[@code = 'a'] = current()/marc:datafield[@tag = '990']/marc:subfield[@code = 'a']]/*[(parent::marc:record/*)]"/>
                                    
                                    <!-- Add a 049 field whose $a has the value of the $hol_049 variable -->
                                    <marc:datafield tag="049" ind1=" " ind2=" ">
                                        <marc:subfield code="a"><xsl:value-of select="$hol_049"/></marc:subfield>
                                        
                                        <!-- For each each 999 field... -->
                                        <xsl:for-each select="marc:datafield[@tag = '999']">
                                            
                                            <!-- For each each $i subfield of each 999 field... -->
                                            <xsl:for-each select="marc:subfield[@code = 'i']">
                                                
                                                <!-- Add a $l subfield with the value of the current node (marc:subfield[@code = 'i'])  -->
                                                <marc:subfield code="l">
                                                    <xsl:value-of select="."/>
                                                </marc:subfield>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </marc:datafield>
                                    
                                    <!-- Add a 590 field with specified values. -->
                                    <marc:datafield tag="590" ind1=" " ind2=" ">
                                        <marc:subfield code="a">FSU Degen Project Source: OCLC</marc:subfield>
                                        <marc:subfield code="5">FTaSU</marc:subfield>
                                    </marc:datafield>
                                    
                                    <!-- Add a 590 field with a concationated string that includes the value of the 990 $a. -->
                                    <marc:datafield tag="590" ind1=" " ind2=" ">
                                        <marc:subfield code="a"><xsl:value-of select="concat('FSU Degen Project ID: ',marc:datafield[@tag = '990']/marc:subfield[@code = 'a'],'.')"/></marc:subfield>
                                        <marc:subfield code="5">FTaSU</marc:subfield>
                                    </marc:datafield>
                                </xsl:when>
                                
                                <!-- Othewise (if the 990 $a of oclc.xml is not the same as the 990 $a of the current node)... -->
                                <xsl:otherwise>
                                    
                                    <!-- Copy the current node (marc:record) and all its elements. -->
                                    <xsl:copy-of select="./*"/>
                                    
                                    <!-- Add fields as above. -->
                                    <marc:datafield tag="049" ind1=" " ind2=" ">
                                        <marc:subfield code="a"><xsl:value-of select="$hol_049"/></marc:subfield>
                                        <xsl:for-each select="marc:datafield[@tag = '999']">
                                            <xsl:for-each select="marc:subfield[@code = 'i']">
                                                <marc:subfield code="l">
                                                    <xsl:value-of select="."/>
                                                </marc:subfield>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </marc:datafield>
                                    <marc:datafield tag="590" ind1=" " ind2=" ">
                                        <marc:subfield code="a">FSU Degen Project Source: SIRSI</marc:subfield>
                                        <marc:subfield code="5">FTaSU</marc:subfield>
                                    </marc:datafield>
                                    <marc:datafield tag="590" ind1=" " ind2=" ">
                                        <marc:subfield code="a"><xsl:value-of select="concat('FSU Degen Project ID: ',marc:datafield[@tag = '990']/marc:subfield[@code = 'a'],'.')"/></marc:subfield>
                                        <marc:subfield code="5">FTaSU</marc:subfield>
                                    </marc:datafield>
                                </xsl:otherwise>
                            </xsl:choose>
                        </marc:record>                                            
            </xsl:for-each>
        </marc:collection>
    </xsl:template>
</xsl:stylesheet>
