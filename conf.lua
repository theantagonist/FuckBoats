function love.conf(t)
	Animations_legacy_support = true
	t.modules.audio = true
	t.modules.keyboard = true
	t.modules.event = true
	t.modules.mouse = true
	t.modules.image = true
	t.modules.graphics = true
	t.modules.timer = true
	t.modules.sound = true
	t.modules.thread = true
	t.console = true
	t.screen.fullscreen = false
	t.screen.vsync = true
	t.title = "Fuck Boats"
	t.author = "The Fair and Magical Jessicorn"
	t.screen.height = 480
	t.screen.width = 640
end