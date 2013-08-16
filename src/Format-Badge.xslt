<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match="Badge[@select='node']">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='badge'>
		<xsl:with-param name='text' select='$node/@TEXT'/>
		<xsl:with-param name='color' select='@color'/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="Badge[@select='parent']">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='badge'>
		<xsl:with-param name='text' select='$node/../@TEXT'/>
		<xsl:with-param name='color' select='@color'/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="Badge[@select='parent.parent']">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='badge'>
		<xsl:with-param name='text' select='$node/../../@TEXT'/>
		<xsl:with-param name='color' select='@color'/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="Badge[not(@select) and @text]">
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='badge'>
		<xsl:with-param name='text' select='@text'/>
		<xsl:with-param name='color' select='@color'/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="Badge[not(@select) and text()]">
	<xsl:param name='node'/>
	<xsl:call-template name='badge'>
		<xsl:with-param name='text' select='.'/>
		<xsl:with-param name='color' select='@color'/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
