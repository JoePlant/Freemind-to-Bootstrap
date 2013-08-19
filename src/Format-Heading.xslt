<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match="Heading[@suppress='true']">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$context'/>
	</xsl:apply-templates>
  </xsl:template>

  <xsl:template match="Heading[not(@suppress='true')]">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<a name="{@id}"/>
	<h1><xsl:value-of select='@name'/></h1>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$context'/>
	</xsl:apply-templates>
  </xsl:template>

  <!--
  <xsl:template match='Heading' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="not(@select)">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context"/>
			<xsl:call-template name='render-heading'>
				<xsl:with-param name='heading' select='.'/>
				<xsl:with-param name='node'/>
				<xsl:with-param name='context' select='$context'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='heading'>
	<xsl:param name='heading'/>
	<xsl:call-template name='render-heading'>
		<xsl:with-param name='heading' select='$heading'/>
		<xsl:with-param name='node' select='.'/>
		<xsl:with-param name='context' select='.'/>
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name='render-heading'>
	<xsl:param name='heading'/>
	<xsl:param name='node'/>
	<xsl:param name='context'/>
	<xsl:variable name='element'>
		<xsl:choose>
			<xsl:when test='$heading/@type'>
				<xsl:value-of select='$heading/@type'/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>h1</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$heading/@link-target='true'">
		<xsl:variable name='link-name'>
			<xsl:choose>
				<xsl:when test='$node/@ID'><xsl:value-of select='$node/@ID'/></xsl:when>
				<xsl:when test='$heading/@id'><xsl:value-of select='$heading/@id'/></xsl:when>
				<xsl:when test='$heading/../@id'><xsl:value-of select='$heading/../@id'/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<a name='{$link-name}'/>
	</xsl:if>
	<xsl:element name='{$element}'>
		<xsl:choose>
			<xsl:when test='$heading/*'>
				<xsl:apply-templates select='$heading/*'>
					<xsl:with-param name='node' select='$node'/>
					<xsl:with-param name='context' select='$context'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test='$node/@TEXT'>
				<xsl:value-of select='$node/@TEXT' />
			</xsl:when>
			<xsl:when test='$header/@text'>
				<xsl:value-of select='$header/@text' />
			</xsl:when>
			<xsl:otherwise>
				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>
  </xsl:template>
-->
</xsl:stylesheet>
