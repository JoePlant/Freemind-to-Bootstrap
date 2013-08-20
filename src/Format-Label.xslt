<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
			
  <xsl:template match='Label' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@select='count'">
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='count($context)'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>	
		<xsl:when test="@select='node'">
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='$node/@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent'">
			<xsl:variable name="text" select="@text"/>
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='$node/../@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent.parent'">
			<xsl:variable name="text" select="@text"/>
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='$node/../../@TEXT'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and @text">
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='@text'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and text()">
			<xsl:call-template name='render-label'>
				<xsl:with-param name='text' select='.'/>
				<xsl:with-param name='color' select='@color'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="render-label">
    <xsl:param name="text">0</xsl:param>
    <xsl:param name="color">green</xsl:param>
    <xsl:variable name="label-class">
      <xsl:choose>
        <xsl:when test="$color = 'grey'"></xsl:when>
        <xsl:when test="$color = 'gray'"></xsl:when>
        <xsl:when test="$color = 'green'">label-success</xsl:when>
        <xsl:when test="$color = 'red'">label-warning</xsl:when>
        <xsl:when test="$color = 'blue'">label-info</xsl:when>
        <xsl:otherwise>label-success</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="span">
      <xsl:attribute name="class">
        <xsl:text>label </xsl:text>
        <xsl:value-of select="$label-class"/>
      </xsl:attribute>
      <xsl:value-of select="$text"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
