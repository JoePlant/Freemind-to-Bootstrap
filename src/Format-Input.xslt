﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 
  <xsl:template match='Input' >
	<xsl:param name='context'/>
	<xsl:param name='node'/>
	<xsl:call-template name='node-as-comment'/>
	<xsl:call-template name='check-context-is-set'>
		<xsl:with-param name='context' select='$context'/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="@persist='true'">
			<xsl:apply-templates select='$node' mode='input'>
				<xsl:with-param name='input' select='.'/>
				<xsl:with-param name='context' select='$context'/>
			</xsl:apply-templates>
		</xsl:when>
	</xsl:choose>
  </xsl:template>
   
  <xsl:template match='node' mode='input'>
	<xsl:param name='input'/>
	<xsl:variable name='node' select='.'/>
	<xsl:choose> 
		<xsl:when test='$allow-data > 0'>
			<input>
				<xsl:apply-templates select='$input/@*' mode='input'>
					<xsl:with-param name='input' select='$input'/>
					<xsl:with-param name='node' select='$node'/>
				</xsl:apply-templates>
			</input>
		</xsl:when>	
		<xsl:when test="$input/@type='checkbox'">
			<i class='icon-edit'/> 
		</xsl:when>
		<xsl:otherwise>
			<span class='muted'> <i class='icon-pencil' /> <xsl:value-of select='$input/@placeholder'/></span>
				<xsl:call-template name='render-br'>
					<xsl:with-param name='count' select='$lines-per-input'/>
				</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name='render-br'>
	<xsl:param name='count'>0</xsl:param>
	<xsl:choose>
		<xsl:when test='$count > 0'>
			<br/>
			<xsl:call-template name='render-br'>
				<xsl:with-param name='count' select= '$count - 1'/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match='@*' mode='input'>
	<xsl:param name='input'/>
	<xsl:param name='node'/>
	<xsl:choose>
		<xsl:when test="name() = 'key'">
			<xsl:attribute name='id'>
				<xsl:value-of select='$node/@ID'/>
			</xsl:attribute>
			<xsl:attribute name='name'>
				<xsl:value-of select='$node/@TEXT'/>
			</xsl:attribute>
			<xsl:if test="not($input/@class)">
				<xsl:attribute name='class'>persist</xsl:attribute>
			</xsl:if>
		</xsl:when>
		<xsl:when test="name() = 'class'">
				<xsl:attribute name='class'>
					<xsl:value-of select='.'/>
					<xsl:text> persist</xsl:text>
				</xsl:attribute>
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
