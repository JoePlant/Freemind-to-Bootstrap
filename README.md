Freemind-to-Bootstrap
================
Extracts information from a Freemind mind-map file and present them in a Twitter Bootstrap file.

Concepts

The parameters.xml file contains the information attributes to extract and format them.

Elements
===

Parameters 
=====
> Root node of the Parameters.xml file.

**Attributes:**
* *none*

**Example:**
```
<Parameters>
    <Heading id='one' name='Menu 1'>
	...
	</Heading>
</Parameters>
```

Heading
=====
> Marks a heading in the output file.

**Attributes:**
* @id = unique identifier used for output file navigation 
* @name - text of the heading (used in the menu and heading)
* @suppress = optional, default @suppress='false' 

**Examples:**
```
<Heading id='ideas' name='Current ideas'>
    ...
</Heading>
```

Section
=====
> Selects nodes from the mindmap using one of the following markers:

* @marker = required:= 'icon', 'parent-text', 'text'
    * when @marker = 'icon' the @icon attributes indicates which of the icons to match
    * when @marker = 'parent-text' the @text attribute selects the nodes that have the text as a parent.
	* when @marker = 'text' the @text attribute selects the nodes which have the text

**Examples:**
```
<Section @marker='icon' icon='idea'>
    ...
</Section>

<Section @marker='parent-text' icon='People'>
    ...
</Section>
```
		
