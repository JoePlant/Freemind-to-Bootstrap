Header
=====
> Outputs an element of the specified type with an optional id and/or text
> Can be used to render a custom header instead of the default header as rendered by the `<Heading />` element
> This element will support the embedding of elements such as header text.

**Attributes:**
* @select - select the value from the freemind nodes using the current context 
	* optional 
	* values: current, parent, parent.parent
		* node : selects the text from the children nodes
		* current : selects the text from the current node
		* parent : selects the text from the parent node
		* parent.parent : selects the text from the grand-parent node
* @text - text to output 
	* optional 
	* not compatible with @select attribute
* @type - the html element type to output
	* values: html elements such as h1, h2, h3
	* default value: h2
* @id - the id to use for the rendered element
* @link-target - 'true' will render the `<a name='link-id'/>` 
	* optional
	* when @select is specified then render the link id as the node's id
	* when no `@select` and there is an `@id` attribute, then render the link id
	* when no `@select` and the parent element has an `@id` attribute, then render the parent id

**Examples:**
```
<!-- outputs a (default) h2 element with 'Header text'  -->
<Header text='Header text' />

<!-- outputs a h3 element with 'Header text'  -->
<Header type='h3' text='Header text' />

<!-- outputs a h3 element with current node's text and a link with the node's id  -->
<Header type='h3' select='current' link-target='true'/>

<!-- outputs a h3 element with parent node's text and a link with the node's id  -->
<Header type='h3' select='parent' link-target='true'/>

<!-- outputs a h2 element with 'Applications' as the text and the <a name='application'/> -->
<Header id="applications" type="h2" link-target="true">
	<html>Applications</html>
</Header> 
```
