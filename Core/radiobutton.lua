local radioButton_s = {}
radioButton_s.false_ = dxCreateTexture("image/radiobutton/rb_f.png")
radioButton_s.true_ = dxCreateTexture("image/radiobutton/rb_t.png")
radioButton_s.false_cli = dxCreateTexture("image/radiobutton/rb_f_s.png")
radioButton_s.true_cli = dxCreateTexture("image/radiobutton/rb_t_s.png")

function dgsDxCreateRadioButton(x,y,sx,sy,text,relative,parent,textcolor,scalex,scaley,defimg_f,hovimg_f,cliimg_f,defcolor_f,hovcolor_f,clicolor_f,defimg_t,hovimg_t,cliimg_t,defcolor_t,hovcolor_t,clicolor_t)
	assert(tonumber(x),"@dgsDxCreateRadioButton argument 1,expect number got "..type(x))
	assert(tonumber(y),"@dgsDxCreateRadioButton argument 2,expect number got "..type(y))
	assert(tonumber(sx),"@dgsDxCreateRadioButton argument 3,expect number got "..type(sx))
	assert(tonumber(sy),"@dgsDxCreateRadioButton argument 4,expect number got "..type(sy))
	if isElement(parent) then
		assert(dgsIsDxElement(parent),"@dgsDxCreateRadioButton argument 7,expect dgs-dxgui got "..dgsGetType(parent))
	end
	local rb = createElement("dgs-dxradiobutton")
	dgsSetType(rb,"dgs-dxradiobutton")
	local _x = dgsIsDxElement(parent) and dgsSetParent(rb,parent,true) or table.insert(MaxFatherTable,1,rb)
	defimg_f = defimg_f or radioButton_s.false_
	hovimg_f = hovimg_f or radioButton_s.false_cli
	cliimg_f = cliimg_f or hovimg_f
	
	defcolor_f = defcolor_f or tocolor(255,255,255,255)
	hovcolor_f = hovcolor_f or tocolor(255,255,255,255)
	clicolor_f = clicolor_f or tocolor(180,180,180,255)
	
	defimg_t = defimg_t or radioButton_s.true_
	hovimg_t = hovimg_t or radioButton_s.true_cli
	cliimg_t = cliimg_t or hovimg_t
	
	defcolor_t = defcolor_t or tocolor(255,255,255,255)
	hovcolor_t = hovcolor_t or tocolor(255,255,255,255)
	clicolor_t = clicolor_t or tocolor(180,180,180,255)
	
	dgsSetData(rb,"rbParent",dgsIsDxElement(parent) and parent or resourceRoot)
	dgsSetData(rb,"image_f",{defimg_f,hovimg_f,cliimg_f})
	dgsSetData(rb,"image_t",{defimg_t,hovimg_t,cliimg_t})
	dgsSetData(rb,"color_f",{defcolor_f,hovcolor_f,clicolor_f})
	dgsSetData(rb,"color_t",{defcolor_t,hovcolor_t,clicolor_t})
	dgsSetData(rb,"text",tostring(text))
	dgsSetData(rb,"textcolor",textcolor or tocolor(255,255,255,255))
	dgsSetData(rb,"textsize",{tonumber(scalex) or 1,tonumber(scaley) or 1})
	dgsSetData(rb,"textImageSpace",{2,false})
	dgsSetData(rb,"shadow",{_,_,_})
	dgsSetData(rb,"font",systemFont)
	dgsSetData(rb,"buttonsize",{16,false})
	dgsSetData(rb,"clip",false)
	dgsSetData(rb,"wordbreak",false)
	dgsSetData(rb,"colorcoded",false)
	dgsSetData(rb,"rightbottom",{"left","center"})
	insertResourceDxGUI(sourceResource,rb)
	triggerEvent("onClientDgsDxGUIPreCreate",rb)
	calculateGuiPositionSize(rb,x,y,relative or false,sx,sy,relative or false,true)
	triggerEvent("onClientDgsDxGUICreate",rb)
	return rb
end

function dgsDxRadioButtonGetSelected(rb)
	assert(dgsGetType(rb) == "dgs-dxradiobutton","@dgsDxRadioButtonGetSelected argument 1,expect number got "..dgsGetType(rb))
	local _parent = dgsGetParent(rb)
	local parent = dgsIsDxElement(_parent) and _parent or resourceRoot
	return dgsGetData(parent,"RadioButton") == rb
end

function dgsDxRadioButtonSetSelected(rb,state)
	assert(dgsGetType(rb) == "dgs-dxradiobutton","@dgsDxRadioButtonSetSelected argument 1,expect number got "..dgsGetType(rb))
	state = state and true or false
	local _parent = dgsGetParent(rb)
	local parent = dgsIsDxElement(_parent) and _parent or resourceRoot
	local _rb = dgsGetData(parent,"RadioButton")
	if state then
		if rb ~= _rb then
			dgsSetData(parent,"RadioButton",rb)
			if dgsIsDxElement(_rb) then
				triggerEvent("onClientDgsDxRadioButtonChanged",_rb,false)
			end
			triggerEvent("onClientDgsDxRadioButtonChanged",rb,true)
		end
		return true
	else
		dgsSetData(parent,"RadioButton",false)
		triggerEvent("onClientDgsDxRadioButtonChanged",rb,false)
		return true
	end
end