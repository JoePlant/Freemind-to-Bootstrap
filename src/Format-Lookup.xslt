<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 
  <xsl:template match='Lookup' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@marker='attribute'">
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name='value' select='$context/attribute[@NAME=$name]/@VALUE'/>
			<xsl:variable name='nodes' select="$root/descendant-or-self::node[attribute[(@NAME = $name) and (@VALUE = $value)]]"/>
			<div class='muted'><xsl:value-of select='$name'/> := <xsl:value-of select='$value'/> <xsl:value-of select='concat("(", count($nodes), ")")'/></div>
			<xsl:apply-templates select="$nodes" mode='lookup'>
				<xsl:with-param name='lookup' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='lookup'>
	<xsl:param name='lookup'/>
	<xsl:variable name='node' select='.'/>
	<xsl:variable name='hierarchy' select='$node/ancestor-or-self::node'/>
	<ul class='breadcrumb'>
		<xsl:for-each select='$hierarchy'>
			<li>
				<a href='{concat("#", @ID)}'><xsl:value-of select='@TEXT'/></a>
				<xsl:if test='position() &lt; last()'>
					<span class='divider'> / </span>
				</xsl:if>
			</li>
		</xsl:for-each>
	</ul>
  </xsl:template>
  
 </xsl:stylesheet>
