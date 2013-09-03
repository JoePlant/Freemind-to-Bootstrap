Section
=====
> Selects nodes from the mindmap using one of the following markers:

**Attributes:**
* @marker = required:= 'icon', 'parent-text', 'text'
    * when @marker = 'icon' the @icon attributes indicates which of the icons to match
    * when @marker = 'parent-icon' the @icon attributes indicates which of the icons to match
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
		
