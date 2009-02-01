<?xml-stylesheet href="http://www.w3.org/StyleSheets/base.css" type="text/css"?><?xml-stylesheet href="http://www.w3.org/2002/02/style-xsl.css" type="text/css"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:foaf="http://xmlns.com/foaf/0.1/"
  xmlns:owl="http://www.w3.org/2002/07/owl#"

  xmlns:dc="http://purl.org/dc/elements/1.1/"

  exclude-result-prefixes="h">

<xsl:param name="ontology_uri"></xsl:param>
<xsl:param name="ontology_name"></xsl:param>
<xsl:param name="ontology_acronym"></xsl:param>
<xsl:param name="ontology_date"></xsl:param>


<!-- Output method XML -->
<xsl:output method="xml" 
  indent="yes"
  omit-xml-declaration="no" 
  encoding="utf-8"  />


  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates />
    </rdf:RDF>

  </xsl:template>


  <xsl:template match="top">
    <owl:Ontology 
      rdf:about="{$ontology_uri}" 
      dc:title="{$ontology_name} From Swig Extracted Ontology ({$ontology_acronym} - FSEO) vocabulary" 
      dc:description="The ({$ontology_acronym} - FSEO) RDF vocabulary, described using W3C RDF Schema and the Web Ontology Language." 
      dc:date="$Date: {$ontology_date} $" 
>

    <xsl:variable name="subject" select='name(.)' />

    <xsl:apply-templates/>



    </owl:Ontology>

  </xsl:template>

<!--
top/attributelist
  <xsl:template match="attributelist">
    <xsl:apply-templates/>
  </xsl:template>

-->

  <xsl:template match="enum">

    <xsl:variable name="enum_name" 
      select="./attributelist/attribute[@name='name']/@value"/>
    
    <rdf:enum rdf:about="{$enum_name}">
      <xsl:apply-templates/>
    </rdf:enum>
    
  </xsl:template>



  <xsl:template match="enumitem">
    <xsl:variable name="subject" select='name(.)' />
    <rdf:Description rdf:about="{$subject}" >
    <xsl:apply-templates/>
    </rdf:Description>
  </xsl:template>

  <xsl:template match="enumitem/attributelist">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="enumitem/attributelist/attribute[@name='name']">
    <xsl:variable name="enum_name" select='@value' />
    <rdf:Description rdf:about="{$enum_name}">
    </rdf:Description>
  </xsl:template>



      
  <!-- don't pass text thru -->
  <xsl:template match="text()">
  </xsl:template>


  
</xsl:stylesheet>