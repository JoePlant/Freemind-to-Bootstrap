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
     <xsl:include href='Format-Label.xslt'/>
     <xsl:include href='Format-Collapse.xslt'/>
     <xsl:include href='Format-Header.xslt'/>
     <xsl:include href='Format-Heading.xslt'/>
	 <xsl:include href='Format-Select.xslt'/>
	 <xsl:include href='Format-Value.xslt'/>
	
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
					<xsl:call-template name='output-parameters-error'/>					

					<hr/>
						<xsl:apply-templates select='$headings'>
							<xsl:with-param name='context' select='$root'/>
						</xsl:apply-templates>
				</div>
			</div>
			
			<xsl:call-template name='about-modal'/>
         </div>
        <script src="jquery/jquery.js"/>
        <script src="bootstrap/js/bootstrap.js"/>
		
      </body>
    </html>
  </xsl:template> 
  
  <xsl:template match='html'>
	<xsl:param name='node'/>		
	<xsl:apply-templates>
		<xsl:with-param name='node' select='$node'/>
	</xsl:apply-templates>
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
          <a class="brand" href="#"> <i class="icon-home icon-white"/> <xsl:value-of select='/map/node/@TEXT'/></a>
          <div class="nav-collapse collapse">
			<p class='navbar-text pull-right'> <a href="#about" data-toggle="modal" title='About'> <i class="icon-info-sign icon-white"/></a></p>
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
		<li class="brand" > <a href="#"> <i class="icon-home"/> <xsl:value-of select='/map/node/@TEXT'/></a></li>
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
	
	<xsl:template name='check-context-is-set'>
		<xsl:param name='context'/>
		<xsl:choose>
			<xsl:when test="$debug = '2'">
				<small class='muted'>
				<xsl:choose>
					<xsl:when test='$context'>$context = <xsl:value-of select='count($context)'/> nodes</xsl:when>
					<xsl:otherwise>No context specified - <xsl:call-template name='show-hierarchy'/></xsl:otherwise>
				</xsl:choose>
				</small>
			</xsl:when>
			<xsl:when test="$debug = '1'">
				<xsl:comment>
					<xsl:choose>
						<xsl:when test='$context'>$context = <xsl:value-of select='count($context)'/> nodes</xsl:when>
						<xsl:otherwise>No context specified - <xsl:call-template name='show-hierarchy'/></xsl:otherwise>
					</xsl:choose>
				</xsl:comment>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name='show-hierarchy'>
		<xsl:for-each select='ancestor-or-self::*'>
			<xsl:if test='position() > 1'> / </xsl:if>
			<xsl:value-of select='name()'/> 
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match='@*' mode='comment'>
		<xsl:text> </xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>:= '</xsl:text>
		<xsl:value-of select='.'/>
		<xsl:text>' </xsl:text>
	</xsl:template>
	
	<xsl:template name='output-parameters-error'>
		<xsl:choose>
			<xsl:when test='$doc-parameters'>
			</xsl:when>
			<xsl:otherwise>
				<div class="modal show">
					<div class="modal-header">
						<h3>Error loading parameters</h3>
					</div>
					<div class="modal-body">
						<p>There has been an error loading the file: <code><xsl:value-of select='$parameters'/></code></p>
						<p>The file may not exist or is not a valid xml file.</p>
						<ul><li>View <a href='errors.txt'>errors</a></li></ul>
					</div>
					<div class="modal-footer"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<xsl:template name='about-modal'>
		<div id="about" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">About</h3>
  </div>
  <div class="modal-body">
    <p>This page was built using the <a href='https://github.com/JoePlant/Freemind-to-Bootstrap'>Freemind-to-Bootstrap</a> library.</p>
	<p>Raw information is stored in a <a href='http://freemind.sourceforge.net/'> <i class='icon-download'/>Freemind</a> mind-map file.</p>
	<p/>
	<p>Source Files:</p>
	<ul>
		<li><a href='mindmap.mm'>Mindmap.mm</a></li>
		<li><a href='parameters.xml'>Parameters.xml</a></li>
	</ul>
	<p class='pull-right'><small>Built using <a href='http://getbootstrap.com/2.3.2/'>Bootstrap 2.3.2</a></small></p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
	</xsl:template>
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
