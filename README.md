[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/naaando/rush/blob/master/LICENSE)

<div align="center">

![Rush](https://github.com/naaando/rush/blob/master/data/icons/com.github.naaando.rush.svg)
# Rush
[![Get it on appcenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.naaando.rush)

Time manager app to break your work into intervals to keep you focused.

</div>

![Rush's main screen](https://github.com/naaando/rush/blob/master/data/main-screen.png)
![Rush's report screen](https://github.com/naaando/rush/blob/master/data/reports-screen.png)

## Building & Installation

You'll need the following dependencies:

* libgtk-3-dev
* libcanberra-dev
* libunity-dev
* libgee-0.8-dev
* libjson-glib-dev
* meson
* valac

Run `meson` to configure the build environment and then `ninja` to build and install

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`, then execute with `com.github.naaando.rush`

    sudo ninja install
    com.github.naaando.rush
