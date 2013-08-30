<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >

<xsl:template match='Table[Column]' >
	<xsl:param name='context'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<table class="table table-condensed table-hover table-bordered ">
		<tbody>
			<tr>
				<xsl:for-each select='Column'>
					<th><xsl:value-of select='@name'/></th>
				</xsl:for-each>
			</tr>
			
		<xsl:choose>	
			<xsl:when test="@marker='icon'">
				<xsl:variable name="icon" select="@icon"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
				<xsl:apply-templates select="$nodes" mode='table'>
					<xsl:with-param name='table' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='parent-text'">
				<xsl:variable name="text" select="@text"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
				<xsl:apply-templates select="$nodes" mode='table'>
					<xsl:with-param name='table' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='text'">
				<xsl:variable name="text" select="@text"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
				<xsl:apply-templates select="$nodes" mode='table'>
					<xsl:with-param name='table' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='node'">
				<xsl:variable name='nodes' select="$context/node"/>
				<xsl:apply-templates select="$nodes" mode='table'>
					<xsl:with-param name='table' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='current'">
				<xsl:variable name='nodes' select="$context"/>
				<xsl:apply-templates select="$nodes" mode='table'>
					<xsl:with-param name='table' select ='.'/>
					<xsl:with-param name='context' select='$nodes'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<div class='text-error'>!!! Unable to interpret "<xsl:value-of select='name()'/> " (@marker='<xsl:value-of select='@marker'/>') </div>
			</xsl:otherwise>
		</xsl:choose>
		</tbody>
	</table>
  </xsl:template>
  
  <xsl:template match='Table[Row]'>
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<table class="table table-condensed table-hover table-bordered ">
		<xsl:apply-templates>
			<xsl:with-param name='table' select ='.'/>
			<xsl:with-param name='context' select='$context'/>
		</xsl:apply-templates>
	</table>
  </xsl:template>
  
  <!--
  <xsl:template match='Table/Row'>
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<tr>
		<xsl:apply-templates>
			<xsl:with-param name='node' select ='$node'/>
			<xsl:with-param name='context' select='$context'/>
		</xsl:apply-templates>
	</tr>
  </xsl:template>
-->
  <xsl:template match='Table/Row' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
		<xsl:choose>	
			<xsl:when test="@marker='icon'">
				<xsl:variable name="icon" select="@icon"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
				<xsl:apply-templates select="$nodes" mode='row'>
					<xsl:with-param name='row' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='parent-text'">
				<xsl:variable name="text" select="@text"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]/node"/>
				<xsl:apply-templates select="$nodes" mode='row'>
					<xsl:with-param name='row' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='text'">
				<xsl:variable name="text" select="@text"/>
				<xsl:variable name='nodes' select="$context/descendant-or-self::node[@TEXT=$text]"/>
				<xsl:apply-templates select="$nodes" mode='row'>
					<xsl:with-param name='row' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='node'">
				<xsl:variable name='nodes' select="$context/node"/>
				<xsl:apply-templates select="$nodes" mode='row'>
					<xsl:with-param name='row' select ='.'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@marker='current'">
				<xsl:variable name='nodes' select="$context"/>
				<xsl:apply-templates select="$nodes" mode='row'>
					<xsl:with-param name='row' select ='.'/>
					<xsl:with-param name='context' select='$nodes'/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test='not(@marker)'>
				<tr>
					<xsl:apply-templates select='@*' mode='row-attributes'/>
					<xsl:apply-templates>
						<xsl:with-param name='node' select ='$node'/>
						<xsl:with-param name='context' select='$context'/>
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<div class='text-error'>!!! Unable to interpret "<xsl:value-of select='name()'/> " (@marker='<xsl:value-of select='@marker'/>') </div>
			</xsl:otherwise>
		</xsl:choose>
  </xsl:template>
    
  <xsl:template match='Table/Row/Data'>
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment' />
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:variable name='cell-type'>
		<xsl:choose>
			<xsl:when test='@type'><xsl:value-of select='@type'/></xsl:when>
			<xsl:otherwise>td</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:element name='{$cell-type}'>
		<xsl:if test='@colspan'>
			<xsl:attribute name='colspan'><xsl:value-of select='@colspan'/></xsl:attribute>
		</xsl:if>
		<xsl:apply-templates>
			<xsl:with-param name='node' select ='$node'/>
			<xsl:with-param name='context' select='$context'/>
		</xsl:apply-templates>
	</xsl:element>
  </xsl:template>
  
  <xsl:template match='node' mode='table'>
	<xsl:param name='table'/>
	<xsl:variable name='node' select='.'/>
	<tr>
		<xsl:for-each select='$table/Column'>
			<td>
				<xsl:apply-templates select='.'>
					<xsl:with-param name='node' select='$node'/>
					<xsl:with-param name='context' select='$node'/>
				</xsl:apply-templates>
			</td>
		</xsl:for-each>
	</tr>
  </xsl:template>
  
  <xsl:template match='node' mode='row'>
	<xsl:param name='row'/>
	<xsl:variable name='node' select='.'/>
	<tr>
		<xsl:apply-templates select='$row/@*' mode='row-attributes'/>
		<xsl:apply-templates select='$row/*'>
			<xsl:with-param name='node' select='$node'/>
			<xsl:with-param name='context' select='$node'/>
		</xsl:apply-templates>
	</tr>
  </xsl:template>
  
  <xsl:template match='Row/@*' mode='row-attributes'>
	<xsl:choose>
		<xsl:when test='@marker'/>
		<xsl:when test='@icon'/>
		<xsl:when test='@text'/>
		<xsl:otherwise><xsl:copy/></xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match='Table/Column[@select="."]'>
	<xsl:param name='node'/>
	<xsl:value-of select='$node/@TEXT'/>
  </xsl:template>
  
  <xsl:template match='Table/Column[@select="parent"]'>
	<xsl:param name='node'/>
	<xsl:value-of select='$node/../@TEXT'/>
  </xsl:template>
  
  <xsl:template match='Table/Column[@select="parent.parent"]'>
	<xsl:param name='node'/>
	<xsl:value-of select='$node/../../@TEXT'/>
  </xsl:template>
  
  <xsl:template match='Table/Column[@select="position"]'>
	<xsl:param name='node'/>
	<xsl:variable name='text' select='@TEXT'/>
	<xsl:value-of select='count($node/preceding-sibling::node) + 1'/>
  </xsl:template>
  
  <xsl:template match='Table/Column[not(@select)]'>
	<xsl:param name='node'/>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
		<xsl:with-param name='context' select='$node'/>
	</xsl:apply-templates>
  </xsl:template>
 
</xsl:stylesheet>
