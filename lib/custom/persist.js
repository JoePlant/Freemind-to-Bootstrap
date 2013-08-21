$(".persist")
  .change(function() {
	var obj = $(this)
	var name = obj.attr('name')
	var id = obj.attr('id')
	var value = obj.val()
	var storage = { id : id, value : value, name : name}
	var previous = $.jStorage.get(id)
	if ((previous === null) || (storage.value !== previous.value))
	{
		$.jStorage.set(id, storage)
		console.log ('Updated: ' + storage)
	}
})

var reload = function()
{
	var keys = $.jStorage.index()
	console.log (keys)
	var persistedforms = $(".persist")
	var count = 0
	var num = 0
	for (var i = 0; i < persistedforms.length; i++)
	{
		num = num + 1
		var element = $(persistedforms[i])
		
		var id = element.attr('id')
		var storage = $.jStorage.get(id)
		if (storage !== null)
		{
			element.val(storage.value)
			count = count + 1
		}
	}
	
	console.log ('count:= ' + count + ' of total: ' + num)
}
	
reload()
