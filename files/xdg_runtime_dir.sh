#!/bin/bash
# Copyright (C): https://wiki.gentoo.org/wiki/Sway#Executing_sway

# This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

if test -z "${XDG_RUNTIME_DIR}"; then
export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
if ! test -d "${XDG_RUNTIME_DIR}"; then
/bin/mkdir "${XDG_RUNTIME_DIR}"
/bin/chmod 0700 "${XDG_RUNTIME_DIR}"
fi
fi
