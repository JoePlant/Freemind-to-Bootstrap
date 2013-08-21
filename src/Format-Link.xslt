<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match="Link[@select='current']">
	<xsl:param name='node'/>
	<a href="{concat('#',$node/@ID)}">			
		<xsl:value-of select='$node/@TEXT'/>
	</a>
  </xsl:template>

  <xsl:template match="Link[@select='parent']">
	<xsl:param name='node'/>
	<a href="{concat('#',$node/../@ID)}">			
		<xsl:value-of select='$node/../@TEXT'/>
	</a>
  </xsl:template>

  <xsl:template match="Link[@select='parent.parent']">
	<xsl:param name='node'/>
	<a href="{concat('#',$node/../../@ID)}">			
		<xsl:value-of select='$node/../../@TEXT'/>
	</a>
  </xsl:template>
 
</xsl:stylesheet>
