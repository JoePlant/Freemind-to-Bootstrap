<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match='Header' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:choose>
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='parent-text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@select='node'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context"/>
			<xsl:apply-templates select="$nodes" mode='header'>
				<xsl:with-param name='header' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='header'>
	<xsl:param name='header'/>
	<xsl:variable name='node' select='.'/>
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
		<a name='{$node/@ID}'/>
	</xsl:if>
	<xsl:element name='{$element}'>
		<xsl:value-of select='$node/@TEXT' />
	</xsl:element>
  </xsl:template>

</xsl:stylesheet>
