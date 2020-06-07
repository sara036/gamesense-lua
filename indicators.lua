---[ Vars ]---
local client_set_event_callback, renderer_indicator, ui_get, ui_reference, ui_new_color_picker, ui_new_label = client.set_event_callback, renderer.indicator, ui.get, ui.reference, ui.new_color_picker, ui.new_label
--------------

---[ Menu ]---
local menu = {
	label = ui_new_label('CONFIG', 'Presets', 'Indicators'),
	color_picker = ui_new_color_picker('CONFIG', 'Presets', 'Indicators', 123, 194, 21, 255),
}
--------------

---[ References ]---
local references = {
	force_safe_point = ui_reference('RAGE', 'Aimbot', 'Force safe point'),
	force_body_aim = ui_reference('RAGE', 'Other', 'Force body aim'),
	quick_stop = { ui_reference('RAGE', 'Other', 'Quick stop') },
	quick_peek_assist = { ui_reference('RAGE', 'Other', 'Quick peek assist') },
	on_shot_aa = { ui_reference('AA', 'Other', 'On shot anti-aim') },
	fake_peek = { ui_reference('AA', 'Other', 'Fake peek') },
}
--------------------

---[ Functions ]---
local function on_paint()

	local r, g, b, a = ui_get(menu.color_picker)

	local IsForceSafePoint = ui_get(references.force_safe_point)
	local IsForceBodyAim = ui_get(references.force_body_aim)
	local IsQuickStop = ui_get(references.quick_stop[1]) and ui_get(references.quick_stop[2])
	local IsQuickPeekAssist = ui_get(references.quick_peek_assist[1]) and ui_get(references.quick_peek_assist[2])
	local IsOnShotAntiAim = ui_get(references.on_shot_aa[1]) and ui_get(references.on_shot_aa[2])
	local IsFakePeek = ui_get(references.fake_peek[1]) and ui_get(references.fake_peek[2])
	
	if IsForceBodyAim then
		renderer_indicator(r, g, b, a, 'BM')
	end
	if IsForceSafePoint then
		renderer_indicator(r, g, b, a, 'SP')
	end
	if IsQuickStop then
		renderer_indicator(r, g, b, a, 'QS')
	end
	if IsQuickPeekAssist then
		renderer_indicator(r, g, b, a, 'QP')
	end
	if IsOnShotAntiAim then
		renderer_indicator(r, g, b, a, 'OS')
	end
	if IsFakePeek then
		renderer_indicator(r, g, b, a, 'FP')
	end
end

client_set_event_callback('paint', on_paint)
-------------------