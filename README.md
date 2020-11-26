# Random-wallpapers.sh

---

A simple script to set your gnome desktop wallpaper randomly !

---

## How to use it

Use it with the following arguments :

```text
random-wallpaper.sh <picture directory: required> <delay in seconds: optionnal>
```

### Things to know

- The directory argument has to be an absolute path.
- The script will create a directory named '.random-wallpaper' in your picture directory, which will contain only links to your picture.
- The default delay is set to 60 seconds
- If you add picture in your directory, you will need to restart the script to update your wallpaper.
- Picture extensions that are supported are `.png`, `.jpg` and `.jpeg`.

---

## Example

```bash
ls /Wallpapers/
```

![Pictures from my wallpapers directory](https://github.com/Dokthoror/Random-wallpapers/blob/main/images/pictures-list.png?raw=true)

All my pictures are in my /Wallpapers directory.

```bash
random-wallpaper.sh /Wallpapers/ 30
```

![Command example](https://github.com/Dokthoror/Random-wallpapers/blob/main/images/command-example.png?raw=true)

I give two arguments :

- the first one is my picture directory (/Wallpapers)
- the second one is my delay (30 seconds)

Finally, just start the script at the startup of your PC with systemd or anything else and enjoy your new wallpapers !
