<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
				
  <xsl:template match='Select' >
	<xsl:param name='context' />
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@marker='parent-text' and not(@recurse)">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='parent-text' and @recurse='true'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/descendant::node"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='parent-icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]/node"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='node'">
			<xsl:variable name='nodes' select="$context/node"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>

		
	<!--
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		
		<xsl:when test="@marker='text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
			<xsl:apply-templates >
				<xsl:with-param name='select' select ='.'/>
				<xsl:with-param name='context' select='$nodes'/>
				<xsl:with-param name='node' select='$nodes'/>
			</xsl:apply-templates>
		</xsl:when>
		-->
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>				
 
</xsl:stylesheet>
