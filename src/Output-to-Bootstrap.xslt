<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                >
 <xsl:output
     method="html"
     doctype-system="about:legacy-compat"
     encoding="UTF-8"
     indent="yes" />

	 <xsl:include href='Format-Table.xslt'/>
	 <xsl:include href='Format-List.xslt'/>
	 <xsl:include href='Format-Link.xslt'/>
	 <xsl:include href='Format-Section.xslt'/>
	 <xsl:include href='Format-Paragraph.xslt'/>
     <xsl:include href='Format-Badge.xslt'/>
     <xsl:include href='Format-Collapse.xslt'/>
     <xsl:include href='Format-Header.xslt'/>
	
	<xsl:param name='debug'>1</xsl:param>
	
	<xsl:param name='parameters'>parameters.xml</xsl:param>
	<xsl:variable name='doc-parameters' select='document($parameters)'/>
	
	<!--<icon BUILTIN="idea"/> -->
	
	<xsl:key name='nodes-by-icon' match='node' use='icon/@BUILTIN'/>
	<xsl:key name='nodes-by-parent-text' match='node' use='../@TEXT'/>
	<xsl:key name='nodes-by-text' match='node' use='@TEXT'/>
	<xsl:key name='nodes-by-id' match='node' use='@ID'/>
	
	<xsl:variable name='dot'>.</xsl:variable>
	<xsl:variable name='root' select='/'/>
	
	<xsl:template match="/">
    <html lang="en">
      <head>
        <title><xsl:value-of select='map/node/@TEXT'/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet"/>
        <link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet"/>
        <style type="text/css">
          body {
          padding-top: 60px;
          padding-bottom: 40px;
          }
          .sidebar-nav {
          padding: 9px 0;
          }

          @media (max-width: 980px) {
          /* Enable use of floated navbar text */
          .navbar-text.pull-right {
          float: none;
          padding-left: 5px;
          padding-right: 5px;
          }
          }
        </style>
      </head>
      <body data-spy="scroll" data-target=".side-nav">
		<xsl:variable name='headings' select='$doc-parameters/Parameters/Heading'/>
		
		
		<xsl:variable name='sections' select="key('nodes-by-icon', 'full-1')"/>
	 
	   <xsl:call-template name="build-top-menu">
			<xsl:with-param name="nodes" select='$headings'/>
		</xsl:call-template>	
	
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span2">
				   <xsl:call-template name="build-side-menu">
						<xsl:with-param name="nodes" select='$headings'/>
					</xsl:call-template>	
				</div>
				<div class='span10'>
					<hr/>
					<xsl:for-each select='$headings'>
						<a name='{@id}'/>
						<h1><xsl:value-of select='@name'/></h1>
						<xsl:apply-templates>
							<xsl:with-param name='context' select='$root'/>
						</xsl:apply-templates>
						<hr/>
					</xsl:for-each>
				</div>
			</div>
         </div>
        <script src="jquery/jquery.js"/>
        <script src="bootstrap/js/bootstrap.js"/>
		<small class='pull-right'>Built using <a href='http://getbootstrap.com/2.3.2/'>Bootstrap 2.3.2</a></small>
      </body>
    </html>
  </xsl:template> 
  
  <xsl:template match='html'>
	<xsl:param name='node'/>		
	<xsl:apply-templates>
		<xsl:with-param name='node' select='$node'/>
	</xsl:apply-templates>
  </xsl:template>

  
  
    <xsl:template name="badge">
    <xsl:param name="text">0</xsl:param>
    <xsl:param name="color">green</xsl:param>
    <xsl:variable name="badge-class">
      <xsl:choose>
        <xsl:when test="$color = 'grey'"></xsl:when>
        <xsl:when test="$color = 'gray'"></xsl:when>
        <xsl:when test="$color = 'green'">badge-success</xsl:when>
        <xsl:when test="$color = 'red'">badge-warning</xsl:when>
        <xsl:when test="$color = 'blue'">badge-info</xsl:when>
        <xsl:otherwise>badge-success</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="span">
      <xsl:attribute name="class">
        <xsl:text>badge </xsl:text>
        <xsl:value-of select="$badge-class"/>
      </xsl:attribute>
      <xsl:value-of select="$text"/>
    </xsl:element>
  </xsl:template>
  
  
   <xsl:template name="create-sections">
    <xsl:param name="nodes"/>
	<xsl:for-each select='$nodes'>
	<a name='{@ID}'/>
	<h3><xsl:value-of select='@TEXT'/></h3>
	<hr/>
	</xsl:for-each>
   </xsl:template>
  
   <xsl:template name="build-top-menu">
    <xsl:param name="nodes"/>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#"><xsl:value-of select='/map/node/@TEXT'/></a>
          <div class="nav-collapse collapse">
            <ul class="nav">
				
				<xsl:for-each select='$nodes'>
				<xsl:choose>
					<xsl:when test='@TEXT'>
					<li>
					<a href="{concat('#', @ID)}"><xsl:value-of select='@TEXT'/></a>
					</li>
					</xsl:when>
					<xsl:otherwise>
					<li>
					<a href="{concat('#', @id)}"><xsl:value-of select='@name'/></a>
					</li>
						
					</xsl:otherwise>
				</xsl:choose>
				</xsl:for-each>  
            </ul>
          </div>
          <!--/.nav-collapse -->
        </div>
      </div>
    </div>
	
  </xsl:template>
  
 <xsl:template name="build-side-menu">
    <xsl:param name="nodes"/>
    <ul class="nav nav-list affix side-nav">
		<li class="brand" ><a href="#"><xsl:value-of select='/map/node/@TEXT'/></a></li>
		<xsl:for-each select='$nodes'>
			<xsl:choose>
				<xsl:when test='@TEXT'>
				<li>
				<a href="{concat('#', @ID)}"><xsl:value-of select='@TEXT'/></a>
				</li>
				</xsl:when>
				<xsl:otherwise>
				<li>
				<a href="{concat('#', @id)}"><xsl:value-of select='@name'/></a>
				</li>
					
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>  
	</ul>
  </xsl:template>

	<xsl:template name='node-as-comment'>
		<xsl:choose>
			<xsl:when test="$debug = '2'">
				<small class="muted">
					<xsl:text>[ </xsl:text>
					<xsl:value-of select='name()'/>
					<xsl:apply-templates select='@*' mode='comment'/> 
					<xsl:text> /]</xsl:text>
				</small>
			</xsl:when>
			<xsl:when test="$debug = '1'">
				<xsl:comment>
					<xsl:text>[ </xsl:text>
					<xsl:value-of select='name()'/>
					<xsl:apply-templates select='@*' mode='comment'/> 
					<xsl:text> /]</xsl:text>
				</xsl:comment>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match='@*' mode='comment'>
		<xsl:text> </xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>:= '</xsl:text>
		<xsl:value-of select='.'/>
		<xsl:text>' </xsl:text>
	</xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
