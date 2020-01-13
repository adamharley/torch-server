Torch for Linux (experimental)
==============================

Building on the work of radu706 of the Torch Discord getting the CLI version of Torch running under Wine, this script brings the GUI version of Torch to the web and VNC so you can have a truly headless server.

If copying an existing world, make sure to change the path of `<LoadWorld>` in `SpaceEngineers-Dedicated.cfg` to `Z:\opt\torch-server\Instance\Saves\`. If you want to create a world within the Torch GUI, change `<Autostart>` to false in `Torch.cfg`, remove the `-autostart` flag in supervisord.conf and restart.

**Note:** Unlike the Docker image, this script *is* able to be easily isolated under its own user and will add a dedicated user `torch-server`.

**Warning:** This setup is experimental. Wine is weird. More CPU cores being available may make performance worse. Your mileage will probably vary.

Ports
-----
* TCP 5900: VNC (x11vnc)
* TCP 6080: Web UI (noVNC)
* UDP 27016: Game server

Scripts
-------
* `install.sh`: Installs Torch and Space Engineers dedicated servers
* `update.sh`: Updates Torch dedicated server (build number must be changed manually)
* `run.sh`: One line script for starting Torch, talk to your local service daemon provider today about how to use it

Known Bugs
----------
* Install script is prone to failing to install silently when switching to the `torch-server` user, if this happens, try deleting `.mono`, praising Clang and running the commands manually
* Torch themes don't work
* Keen's remote API doesn't work

Build Notes
-----------
* See Docker image for initial build notes
* Running supervisord as another user to the current one does not change `WINEPREFIX` accordingly
* `WINEPREFIX` must be manually set for `winetricks` to install complex verbs while switched to the server user
