<?xml-stylesheet href="http://www.w3.org/StyleSheets/base.css" type="text/css"?><?xml-stylesheet href="http://www.w3.org/2002/02/style-xsl.css" type="text/css"?>
<!DOCTYPE rdf:RDF [
  <!ENTITY owl "http://www.w3.org/2002/07/owl#">
  <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
  <!ENTITY swig_tree.h.enum.tree_code_class2 "http://github.com/h4ck3rm1k3/gcc/blob/introspector_branch/gcc/gcc/grddl/swig_tree.h.enum.tree_code_class2.owl#">
  <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
]>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:foaf="http://xmlns.com/foaf/0.1/"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:vs="http://www.w3.org/2003/06/sw-vocab-status/ns#"
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
    <rdf:RDF xml:base="{$ontology_uri}">
      <xsl:apply-templates />
    </rdf:RDF>
  </xsl:template>


  <xsl:template match="top">
    <owl:Ontology 
      rdf:about="" 
      dc:title="{$ontology_name} From Swig Extracted Ontology ({$ontology_acronym} - FSEO) vocabulary" 
      dc:description="The ({$ontology_acronym} - FSEO) RDF vocabulary, described using W3C RDF Schema and the Web Ontology Language." 
      dc:date="$Date: {$ontology_date} $" 
>
    </owl:Ontology>
    <xsl:variable name="subject" select='name(.)' />
    <!-- 
         base class
         -->
    <owl:Class rdf:about="#enum">
      <owl:disjointWith rdf:resource="&owl;Nothing"/>
    </owl:Class>

    <xsl:apply-templates/>

  </xsl:template>


  <xsl:template match="enum">

    <xsl:variable name="enum_name" 
      select="./attributelist/attribute[@name='name']/@value"/>


    <!--
      rdfs:label="{$enum_name}" 
      vs:term_status="experimental"
         -->
    <owl:Class 
      rdf:about="#enum_{$enum_name}" 

      rdfs:comment="An enum of type {$enum_name}"

      >
      <rdfs:subClassOf rdf:resource="#enum"/>

      <owl:disjointWith rdf:resource="&owl;Nothing"/>
    </owl:Class>
    <xsl:apply-templates/>   
  </xsl:template>

  <!--
  <xsl:template match="enumitem">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="enumitem/attributelist">
    <xsl:apply-templates/>
  </xsl:template>
  -->

  <xsl:template match="enumitem/attributelist/attribute[@name='name']">
    <xsl:variable name="enum_name" select='@value' />
    
    <xsl:variable name="parent_enum_name" 
      select="../../../attributelist/attribute[@name='name']/@value"/>


    <!--
      rdfs:label="{$enum_name}" 
      vs:term_status="experimental"
         -->    

    <owl:Class 
      rdf:about="#enum_value_{$enum_name}" 

      rdfs:comment="An value of type {$enum_name}"

      >
      <rdfs:subClassOf  rdf:resource="#enum_{$parent_enum_name}"/>
 


    </owl:Class>

  </xsl:template>



      
  <!-- don't pass text thru -->
  <xsl:template match="text()">
  </xsl:template>


  
</xsl:stylesheet>