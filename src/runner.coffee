# Module to control application life.
app = require('app')
# Module to create native browser window.
BrowserWindow = require('browser-window')

# Report crashes to our server.
require('crash-reporter').start()

# Keep a global reference of the window object, if you don't, the window will
# be closed automatically when the JavaScript object is GCed.
mainWindow = null;

# Quit when all windows are closed.
app.on 'window-all-closed', () ->
  # On OS X it is common for applications and their menu bar
  # to stay active until the user quits explicitly with Cmd + Q
  if process.platform != 'darwin'
    app.quit()


# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
app.on 'ready', () ->
  # Create the browser window.
  # mainWindow = new BrowserWindow({width: 800, height: 600});
  mainWindow = new BrowserWindow
    width: 1024
    height: 768
    'node-integration': false

  # and load the index.html of the app.
  mainWindow.loadUrl('file://' + __dirname + '/index.html')

  # Open the devtools.
  # mainWindow.openDevTools();

  # Emitted when the window is closed.
  mainWindow.on 'closed', () ->
    # Dereference the window object, usually you would store windows
    # in an array if your app supports multi windows, this is the time
    # when you should delete the corresponding element.
    mainWindow = null
