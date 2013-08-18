<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match="Collapse[@type='summary']">
	<xsl:param name='node'/>
	<xsl:param name='context'/>
	<xsl:variable name='parent' select='..'/>
	<xsl:variable name='unique-id' select="concat(generate-id($node), '-', generate-id($parent))"/>
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
	<xsl:variable name='parent' select='..'/>
	<xsl:variable name='unique-id' select="concat(generate-id($node), '-', generate-id($parent))"/>
	<div id="{$unique-id}" class='collapse'>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$node'/>
	</xsl:apply-templates>
	</div>
  </xsl:template>
</xsl:stylesheet>
