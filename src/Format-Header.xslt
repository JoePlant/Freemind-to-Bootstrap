<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match='Header' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@select='parent'">
			<xsl:variable name='nodes' select="$context/.."/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@select='parent.parent'">
			<xsl:variable name='nodes' select="$context/.."/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@select='node'">
			<xsl:variable name='nodes' select="$context/node"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@select='current'">
			<xsl:variable name='nodes' select="$context"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="not(@select)">
			<xsl:variable name="text" select="@text"/>
			<xsl:call-template name='render-header'>
				<xsl:with-param name='header' select='.'/>
				<xsl:with-param name='node'/>
				<xsl:with-param name='context' select='$context'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Select found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='header'>
	<xsl:param name='header'/>
	<xsl:call-template name='render-header'>
		<xsl:with-param name='header' select='$header'/>
		<xsl:with-param name='node' select='.'/>
		<xsl:with-param name='context' select='.'/>
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name='render-header'>
	<xsl:param name='header'/>
	<xsl:param name='node'/>
	<xsl:param name='context'/>
	<xsl:variable name='element'>
		<xsl:choose>
			<xsl:when test='$header/@type'>
				<xsl:value-of select='$header/@type'/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>h2</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$header/@link-target='true'">
		<xsl:variable name='link-name'>
			<xsl:choose>
				<xsl:when test='$header/@select and $node/@ID'><xsl:value-of select='$node/@ID'/></xsl:when>
				<xsl:when test='$header/@id'><xsl:value-of select='$header/@id'/></xsl:when>
				<xsl:when test='$header/../@id'><xsl:value-of select='$header/../@id'/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<a name='{$link-name}'/>
	</xsl:if>
	<xsl:element name='{$element}'>
		<xsl:choose>
			<xsl:when test='$header/*'>
				<xsl:apply-templates select='$header/*'>
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

</xsl:stylesheet>
