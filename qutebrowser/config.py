
config.load_autoconfig(True)

# Default stuff
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/mdlafrance/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/mdlafrance/.local/share/qutebrowser/userscripts/*')

# Uncomment to user city lights
# config.source('themes/qute-city-lights/city-lights-theme.py')

# Uncomment to use catpuccin
config.source('themes/catpuccin/setup.py')

# Keybinds
config.bind("<Shift+j>", "tab-prev")
config.bind("<Shift+k>", "tab-next")

config.bind("<Ctrl+1>", "tab-focus 1")
config.bind("<Ctrl+2>", "tab-focus 2")
config.bind("<Ctrl+3>", "tab-focus 3")
config.bind("<Ctrl+4>", "tab-focus 4")
config.bind("<Ctrl+5>", "tab-focus 5")
config.bind("<Ctrl+6>", "tab-focus 6")
config.bind("<Ctrl+7>", "tab-focus 7")
config.bind("<Ctrl+8>", "tab-focus 8")
config.bind("<Ctrl+9>", "tab-focus -1")

c.url.start_pages = [
        "https://google.com"
        ]

c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
}
