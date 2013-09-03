List
=====
> Outputs the selected nodes as a list

**Attributes**

* @marker = the nodes to select
	* required
	* values := 'icon', 'parent-icon', 'parent-text', 'text'
		* 'icon' : the @icon attributes indicates which of the icons to match
		* 'parent-icon' : the @icon attributes indicates which of the icons to match
		* 'parent-text' : the @text attribute selects the nodes that have the text as a parent.
		* 'text' : the @text attribute selects the nodes which have the text
* @recurse = return all nodes as an embedded list
	* optional
	* default = false
	* values = true, false
		* true : recurse selecting child nodes as well
		* false : only select the current nodes
	
**Examples:**
```
<!-- Build a list of nodes with the icon = 'idea' -->
<List @marker='icon' icon='idea' />

<!-- Build a list of nodes that are children of the node with text 'People' and show all child nodes -->
<List @marker='parent-text' text='People' recurse='true' />
```
		
