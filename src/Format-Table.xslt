<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
   <xsl:template match='Table' >
	<table class="table table-bordered table-hover">
		<thead>
			<tr>
		<xsl:for-each select='Column'>
			<th><xsl:value-of select='@name'/></th>
		</xsl:for-each>
			</tr>
		</thead>
		<tbody>
			
	<xsl:choose>	
		<xsl:when test="@marker='icon'">
			
			<xsl:variable name="icon" select="@icon"/>
			<xsl:variable name='nodes' select="$root/descendant-or-self::node[icon/@BUILTIN=$icon]"/>
			<xsl:apply-templates select="$nodes" mode='table'>
				<xsl:with-param name='table' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='parent-text'">
			
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$root/descendant-or-self::node[@TEXT=$text]/node"/>
			<xsl:apply-templates select="$nodes" mode='table'>
				<xsl:with-param name='table' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="@marker='text'">
			
			<xsl:variable name="text" select="@text"/>
			<xsl:variable name='nodes' select="$root/descendant-or-self::node[@TEXT=$text]"/>
			<xsl:apply-templates select="$nodes" mode='table'>
				<xsl:with-param name='table' select ='.'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
		</tbody>
	</table>
  </xsl:template>

  <xsl:template match='node' mode='table'>
	<xsl:param name='table'/>
	<xsl:variable name='node' select='.'/>
	<tr>
	<xsl:for-each select='$table/Column'>
		<td>
			<xsl:apply-templates select='.'>
				<xsl:with-param name='node' select='$node'/>
			</xsl:apply-templates>
		</td>
	</xsl:for-each>
	</tr>
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
  
  <xsl:template match='Table/Column[not(@select)]'>
	<xsl:param name='node'/>
	<xsl:apply-templates >
		<xsl:with-param name='node' select='$node'/>
	</xsl:apply-templates>
  </xsl:template>
 
</xsl:stylesheet>
