<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 
  <xsl:template match='TextArea' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@persist='true'">
			<xsl:apply-templates select='$node' mode='textarea'>
				<xsl:with-param name='textarea' select='.'/>
				<xsl:with-param name='context' select='$context'/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<div>!!! No Marker found</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='textarea'>
	<xsl:param name='textarea'/>
	<xsl:variable name='node' select='.'/>
	<xsl:choose> 
		<xsl:when test='$allow-data > 0'>
			<textarea>
				<xsl:apply-templates select='$textarea/@*' mode='textarea'>
					<xsl:with-param name='textarea' select='$textarea'/>
					<xsl:with-param name='node' select='$node'/>
				</xsl:apply-templates>
			</textarea>
		</xsl:when>
		<xsl:otherwise>
			<div class='muted'><i class='icon-pencil' /> <xsl:value-of select='$textarea/@placeholder'/>
				<br/>
				<br/>
				<br/>
			</div>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match='@*' mode='textarea'>
	<xsl:param name='textarea'/>
	<xsl:param name='node'/>
	<xsl:choose>
		<xsl:when test="name() = 'key'">
			<xsl:attribute name='id'>
				<xsl:value-of select='$node/@ID'/>
			</xsl:attribute>
			<xsl:attribute name='name'>
				<xsl:value-of select='$node/@TEXT'/>
			</xsl:attribute>
			<xsl:if test="not($textarea/@class)">
				<xsl:attribute name='class'>persist</xsl:attribute>
			</xsl:if>
		</xsl:when>
		<xsl:when test="name() = 'placeholder'">
			<xsl:if test='$render-input-placeholder > 0'>
				<xsl:copy/>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy />
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
 </xsl:stylesheet>
