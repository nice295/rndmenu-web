Framer.Extras.Hints.disable()

# getDate
getDate = ->
	today = new Date
	mm = today.getMonth() + 1 
	dd = today.getDate()
	if dd < 10  
		dd = '0' + dd  
	if mm < 10  
		mm = '0' + mm  
	yyyy = today.getFullYear() 
	return ""+yyyy+mm+dd

# Variables
gutter = 12

{Firebase} = require 'firebase'
menuDB = new Firebase
	projectID: "rndmenu"
	secret: "8aHinuTCIWkUQaRhztogGYq0BnzqrvIJDq6kKrkb" 

scroll = ScrollComponent.wrap(contents)
scroll.scrollHorizontal = false
scroll.sendToBack()
scroll.contentInset =
	top: 8
	right: 0
	bottom: 8
	left: 0

menuDB.get "/menu/"+getDate()+"/1식당/점심", (menus) ->
	menusArray = _.toArray(menus)
	for menuData, index in menusArray
		item = _item.copySingle()	
		item.parent = scroll.content
		item.visible = true
		item.y = index * (item.height + gutter) + 64
		
		menu = _menu.copySingle()
		menu.parent = item
		menu.text = menuData.menu
		menu.width = item.width * 0.8
				
		restaurant = _restaurant.copySingle()
		restaurant.parent = item
		restaurant.text = menuData.restaurant

		sidemenu = _sidemenu.copySingle()
		sidemenu.parent = item
		sidemenu.text = menuData.description
		sidemenu.y = Align.bottom(-8)
		sidemenu.width = item.width * 0.8
		
		item.animate
			y: index * (item.height + gutter) + 8
			time: 0.5
			options: 
				curve: Spring(damping: 0.3)
				delay: 0.2 * (index + 1)
		

