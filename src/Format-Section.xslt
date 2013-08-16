<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match='Section' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:choose>	
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<xsl:apply-templates select="$nodes" mode='section'>
				<xsl:with-param name='section' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='parent-text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
			<xsl:apply-templates select="$nodes" mode='section'>
				<xsl:with-param name='section' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
			<xsl:apply-templates select="$nodes" mode='section'>
				<xsl:with-param name='section' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>				
				
  <xsl:template match='node' mode='section'>
	<xsl:param name='section'/>
	<xsl:variable name='node' select='.'/>
	<xsl:variable name='unique-id' select="concat(generate-id($node), '-', generate-id($section))"/>
	<a name='{$node/@ID}'/>
	<h2 data-toggle='collapse' data-target="{concat('#', $unique-id)}"><xsl:value-of select='$node/@TEXT'/></h2>
	<div id="{$unique-id}" class='collapse'>
	<xsl:apply-templates select='$section/*'>
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$node'/>
	</xsl:apply-templates>
	</div>
  </xsl:template>
 				
</xsl:stylesheet>
