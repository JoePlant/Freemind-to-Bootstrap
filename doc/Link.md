Link
=====
> Renders the node as a hyper-link to the specified node

**Attributes:**
* @select - select the value from the freemind nodes using the current context 
	* optional 
	* values: count, node, parent, parent.parent
		* node : selects the text and id from the current node
		* parent : selects the text and id from the parent node
		* parent.parent : selects the text and id from the grand-parent node
* @class - class for the link
	* optional

**Examples:**
```
<!-- hyper link to the node -->
<Link name='node'/>

<!-- hyper link to the parent node -->
<Link name='parent'/>

```
