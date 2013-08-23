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
		console.log ('Updated: ' + storage.value)
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
		else 
		{
			element.val(null);
		}
	}
	
	console.log ('count:= ' + count + ' of total: ' + num)
}

var savedata = function()
{
	var keys = $.jStorage.index()
	var data = [];
	var count = 0
	for (var i = 0; i < keys.length; i++)
	{
		var key = keys[i];
		var storage = $.jStorage.get(key)
		if (storage !== null)
		{
			console.log (key + ":" + storage)
			data.push (storage)
			//data = data + '\n' + '<data id="' + key + '" name="' + storage.name + '" >' + storage.value + '</data>'
			count = count + 1
		}
	}
	//data = data + '\n' + '</saved>'
	var json = JSON.stringify(data);
	$('#data-modal-data').text(json)
	console.log(json)
	alert(json )
	$("#data").modal('show')
}

var flushdata = function()
{
	$.jStorage.flush();
}

var setupMenus = function ()
{
	$('#menu-hide-all').click(function(e) {
		console.log ('hide all')
		$(".collapse").collapse('hide');
		e.preventDefault();
	})

	$('#menu-show-all').click(function(e) {
		console.log ('show all')
		$(".collapse").collapse('show');
		e.preventDefault();
	})
	
	$('#menu-data-save').click(function(e) {
		console.log('show data')
		savedata();
		//e.preventDefault();
	})
	
	$('#menu-flush-data').click(function(e) {
		console.log('flush data')
		flushdata();
		reload();
		e.preventDefault();
	})
}

reload()
setupMenus();
