Value
=====
> Renders the text from the current node as a span element

**Attributes:**
* @select - select the value from the freemind nodes using the current context 
	* optional 
	* values: count, position, current, parent, parent.parent
		* count : counts the number of nodes
		* position : shows the position of the node 
		* current : selects the text from the current node
		* parent : selects the text from the parent node
		* parent.parent : selects the text from the grand-parent node
* @text - text to output 
	* optional 
	* not compatible with @select attribute
* @class - class for the value

**Examples:**
```
<!-- outputs a span with the specified text 'Inputs' -->
<Value text='Inputs' />

<!-- outputs a span with current node as text -->
<Value select='current' />

<!-- outputs a span with the parent node as text and class of pull-right -->
<Value select='parent' class='pull-right'/>

<!-- outputs a span with the specified text 'Inputs' -->
<Value>Inputs</Value>
```
