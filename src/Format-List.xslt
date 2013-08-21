<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 
  <xsl:template match='List' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@marker='icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='list'>
					<xsl:with-param name='list' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:when test="@marker='parent-icon'">
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]/node"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='list'>
					<xsl:with-param name='list' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:when test="@marker='parent-text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='list'>
					<xsl:with-param name='list' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:when test="@marker='text'">
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
			<ul>
				<xsl:apply-templates select="$nodes" mode='list'>
					<xsl:with-param name='list' select ='.'/>
				</xsl:apply-templates>
			</ul>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='list'>
	<xsl:param name='list'/>
	<xsl:variable name='node' select='.'/>
	<li><xsl:value-of select='$node/@TEXT' />
		<xsl:if test="$list/@recurse = 'true'">
			<xsl:if test="count($node/node) > 0">
				<ul>
					<xsl:apply-templates select="$node/node" mode='list'>
						<xsl:with-param name='list' select ='$list'/>
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</xsl:if>
	</li>
  </xsl:template>
  
 </xsl:stylesheet>
