# TV Dashboard

A simple wrapper to run a dashboard with Chromium, cycling though the tabs. Has very minimal dependencies and is suitable for a Raspberry Pi running Raspbian.

## Prerequisites

- Some kind of Debian based OS (I'm using Raspbian).
- A user who can run sudo commands.
- If using Raspberry Pi you may need to get rid of a black border with some monitors/TVs: `/boot/config.txt` - `disable_overscan=1`

## Bootstrap

Clone this repository to the computer running the dashboard.

Run the following command to install dependencies (for Debian based OS) and setup autologin:

```
./bootstrap.sh
```

Add the URLs you want to cycle through to `urls.txt`, one URL per line. Ideally these should not require logins, but you can modify `xsession` if you need to send any key presses after page load.

## Running

Restart and the dashboard should come up with no additional interaction required.
