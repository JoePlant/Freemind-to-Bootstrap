<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
			
  <xsl:template match='Value' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@select='count'">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='count($context)'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>	
		<xsl:when test="@select='current'">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='$node/@TEXT'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent'">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='$node/../@TEXT'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='parent.parent'">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='$node/../../@TEXT'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@select='position'">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='count($node/preceding-sibling::node) + 1'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and @text">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='@text'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="not(@select) and text()">
			<xsl:call-template name='render-value'>
				<xsl:with-param name='text' select='.'/>
				<xsl:with-param name='value' select='.'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="render-value">
	<xsl:param name='value'/>
    <xsl:param name="text">0</xsl:param>
    <xsl:variable name="value-class">
      <xsl:choose>
        <xsl:when test="$value/@class"><xsl:value-of select='$value/@class'/></xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="span">
	  <xsl:if test='string-length($value-class) > 0'>
		<xsl:attribute name="class">
			<xsl:value-of select='$value-class'/>
		</xsl:attribute>
	  </xsl:if>
      <xsl:value-of select="$text"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
