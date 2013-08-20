<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match="Collapse[@type='summary']">
	<xsl:param name='node'/>
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:variable name='collapse' select='.'/>
	<xsl:variable name='unique-id'>
		<xsl:call-template name='collapse-calculate-unique-id'>
			<xsl:with-param name='node' select='$node'/>
			<xsl:with-param name='collapse' select='$collapse'/>
		</xsl:call-template>
	</xsl:variable>
	<div data-toggle='collapse' data-target="{concat('#', $unique-id)}">
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$context'/>
	</xsl:apply-templates>
	</div>
  </xsl:template>

  <xsl:template match="Collapse[@type='collapsed']">
	<xsl:param name='node'/>
	<xsl:param name='context'/>
  	<xsl:call-template name='node-as-comment'/>
	<xsl:variable name='collapse' select='.'/>
	<xsl:variable name='unique-id'>
		<xsl:call-template name='collapse-calculate-unique-id'>
			<xsl:with-param name='node' select='$node'/>
			<xsl:with-param name='collapse' select='$collapse'/>
		</xsl:call-template>
	</xsl:variable>
	<div id="{$unique-id}" class='collapse'>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$context'/>
	</xsl:apply-templates>
	</div>
  </xsl:template>
  
  <xsl:template name='collapse-calculate-unique-id'>
	<xsl:param name='node'/>
	<xsl:param name='collapse' />
	<xsl:choose>
		<xsl:when test='count($node) > 0'>
			<xsl:value-of select='generate-id($node)' />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>node</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>-</xsl:text>
	<xsl:choose>
		<xsl:when test='$collapse/@id'>
			<xsl:value-of select='$collapse/@id' />
		</xsl:when>
		<xsl:when test='count($collapse) > 0'>
			<xsl:value-of select='generate-id($collapse/..)' />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>collapse</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
