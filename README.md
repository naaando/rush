[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/naaando/rush/blob/master/LICENSE)

<div align="center">

![Rush](https://github.com/naaando/rush/blob/master/data/icons/com.github.naaando.rush.svg)
# Rush
[![Get it on appcenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.naaando.rush)

Time manager app to break your work into intervals to keep you focused.

</div>

![Rush's main screen](https://github.com/naaando/rush/blob/master/data/main-screen.png)
![Rush's report screen](https://github.com/naaando/rush/blob/master/data/reports-screen.png)

## Dependencies

You'll need the following dependencies:
* libgtk-3-dev
* libcanberra-dev
* libunity-dev
* libgee-0.8-dev
* libjson-glib-dev
* meson
* valac >= 0.40.3

## Building and Installation

You can specify `/usr` , `/usr/local` or `$HOME/.local`
I recommend to stick with `/usr` if you aren't sure, choosing different paths may lead issues with the glib schemas.

```
meson build --prefix /usr/
# Don't use sudo, ninja will ask for permission while running
ninja -C build install
```
