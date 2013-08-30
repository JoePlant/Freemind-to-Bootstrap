<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 
  <xsl:template match='Paragraph' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:choose>
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='paragraph'>
					<xsl:with-param name='paragraph' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:when test="@marker='parent-text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='paragraph'>
					<xsl:with-param name='paragraph' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:when test="@marker='text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='paragraph'>
					<xsl:with-param name='paragraph' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='paragraph'>
	<xsl:param name='paragraph'/>
	<xsl:variable name='node' select='.'/>
	<xsl:element name='p'>
		<xsl:if test='$paragraph/@class'>
			<xsl:attribute name='class'><xsl:value-of select='$paragraph/@class'/></xsl:attribute>
		</xsl:if>
		<xsl:value-of select='$node/@TEXT' />
	</xsl:element>
  </xsl:template>
  
 </xsl:stylesheet>
