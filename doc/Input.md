Input
=====
> Used to put an Input element in the system that will be matched to the Mind Map node.

**Attributes:**
* @persist - Should the element's value be persisted across sessions.
	* optional
	* default : false
	* values : 'true', 'false'
		* true : the input is marked up to persist the values
		* false : the input with 
* @key - how to select the node
* @class : the CSS class for the input element

**Examples:**
```
<!-- Outputs a Text Input area that will be tied to the current node in the mind map -->
<Input type="text" placeholder="Enter value here..." persist="true" key="current"/>

<!-- Outputs a checkbox -->
<Input type="checkbox" persist="true" value="Present" key="current"/>
```
