TextArea
=====
> Renders an TextArea element for the current mind-map node.

**Attributes:**
* @persist - Should the element's value be persisted across sessions.
	* optional
	* default : false
	* values : 'true', 'false'
		* true : the input is marked up to persist the values
		* false : the input with 
* @key - how to select the node
* @class - the CSS class for the input element
* @placeholder - standard html placeholder input

**Examples:**
```
<!-- Outputs a TextArea that will be tied to the current node in the mind map -->
<TextArea placeholder="Enter value here..." persist="true" key="current"/>

<!-- Output a TextArea with the specified attributes for current node -->
<TextArea placeholder="{Please enter comments here...}" rows="6" cols="50" persist="true" key="current" />

<!-- Outputs a TextArea for the current node and persist the values across sessions -->
<TextArea persist="true" key="current"/>
```
