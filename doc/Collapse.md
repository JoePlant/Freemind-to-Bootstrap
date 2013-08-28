Collapse
=====
> Markup to show the collapse summary and section.  The collapse section is collapsed by default.
> Renders a div for the `summary` and `collapse` sections with the id and classes required.
> Uses the Collapse component from Twitter Bootstrap.

**Attributes:**
* @type - The type of collapse header 
	* required
	* values: summary, collapsed
		* summary : renders the collapse header that will be always visible
		* collapsed : renders the collapsed section
* @id - used to generage a unique id for the rendered div
	* optional
	* if specified will be used as part of the id.
	* if not specified then the unique id is determined from the `<Collapse>` parent.

** Markup **
```
<Collapse type='summary'>
    ...
</Collapse>
<Collapse type='collapsed'>
	...
</Collapse>
```
** Rendered **
```
<div data-toggle='collapse' data-target='#generated-id'>
    ...
</div>
<div id='generated-id' class='collapsed'>
    ...
</div>
```

**Example Markup:**
```
<!-- marks the section that will be the always visible  -->
<Collapse type='summary'>
    ...
</Collapse>

<!-- marks the section that will be collapsed -->
<Collapse type='collapsed'>
	...
</Collapse>

<!-- use the collapse-key as the html id attribute -->
<Collapse type='summary' id='collapse-key'>
	...
</Collapse>
<Collapse type='collapsed' id='collapse-key'>
	...
</Collapse>

```
