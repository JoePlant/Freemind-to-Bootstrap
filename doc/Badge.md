Badge
=====
> Outputs a twitter bootstrap badge using either the @text attribute or the @select attribute

**Attributes:**
* @select - select the value from the freemind nodes using the current context 
	* optional 
	* values: count, node, parent, parent.parent
		* count : counts the number of nodes
		* node : selects the text from the current node
		* parent : selects the text from the parent node
		* parent.parent : selects the text from the grand-parent node
* @text - text to output 
	* optional 
	* not compatible with @select attribute
* @color - color of the badge 
	* values: green, red, blue, grey
	* default value: green
* @class - class for the badge

**Examples:**
```
<!-- outputs a grey badge with the count of idea nodes on the right-->
<Select marker='icon' icon='idea'>
	<Badge color='grey' select='count' class='pull-right' />
</Select>

<!-- outputs a green badge as '5' -->
<Badge text='5' color='green'/>

<!-- outputs a green badge with the current node as text -->
<Badge select='node' color='green'/>

<!-- outputs a blue badge with the parent node as text -->
<Badge select='parent' color='blue'/>

<!-- outputs a red badge with the text -->
<Badge color='red'>10</Badge>
```
