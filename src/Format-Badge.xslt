<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
			
  <xsl:template match='Badge' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@select='count'">
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='count($context)'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>	
		<xsl:when test="@select='node'">
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='$node/@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent'">
			<xsl:variable name="text" select="@text"/>
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='$node/../@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent.parent'">
			<xsl:variable name="text" select="@text"/>
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='$node/../../@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and @text">
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='@text'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and text()">
			<xsl:call-template name='badge'>
				<xsl:with-param name='text' select='.'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>

		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

  
</xsl:stylesheet>
