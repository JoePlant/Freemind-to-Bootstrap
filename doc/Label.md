Label
=====
> Outputs a twitter bootstrap label using either the @text attribute or the @select attribute

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
* @color - color of the label 
	* values: green, red, blue, grey
	* default value: green
* @class - class for the label

**Examples:**
```
<!-- outputs a green label as 'Label text' -->
<Label text='Label text' color='green'/>

<!-- outputs a green label with the current node as text -->
<Label select='node' color='green'/>

<!-- outputs a blue label with the parent node as text -->
<Label select='parent' color='blue'/>

<!-- outputs a blue label with the text -->
<Label color='red'>Label text</Label>

```
