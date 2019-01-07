#!/bin/bash
# kde-installer (c) Karim 'TheSola10' Vergnes <thesola10@bobile.fr>
# License: GNU GPLv3
# Requires Fedora's dnf

if ! which blih > /dev/null 2>&1 || ! which dnf > /dev/null 2>&1
then
    echo "This program is only compatible with Fedora as distributed by Epitech. Contact me at <karim.vergnes@epitech.eu> for more info."
    exit 3
elif [[ $UID != 0 ]]
then
    echo "This program must be run as root. Try 'sudo $0 $@'."
    exit 1
fi

# Installer

__install()
{
    dnf install "@kde-desktop" breeze-gtk                                    &&\
    systemctl disable lightdm.service                                        &&\
    systemctl enable sddm.service                                            &&\
    cat > /home/$SUDO_USER/.gtkrc-2.0 <<EOF 
include "/usr/share/themes/Breeze/gtk-2.0/gtkrc"
style "user-font"
{
    font_name="Cantarell Regular"
}
widget_class "*" style "user-font"
gtk-font-name="Cantarell Regular 11"
gtk-theme-name="Breeze"
gtk-icon-theme="breeze"
EOF
    cat > /home/$SUDO_USER/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-font-name=Cantarell Regular 11
gtk-theme-name=Breeze
gtk-icon-theme-name=Breeze
EOF
}


if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] 
then
    echo "== kde-installer. (c) Karim Vergnes <karim.vergnes@epitech.eu> =="
    echo
    echo "\"It's better than XFCE!\" -- me, and probably you afterwards."
    echo
    echo "kde-installer is used this way: "
    echo "kde-installer [--help|--phony]"
    echo
    echo "Options:"
    echo "  -h/--help  - Show this help"
    echo "  -p/--phony - Only print the commands to execute"
elif [[ "$1" == "-p" ]] || [[ "$1" == "--phony" ]]
then
    type __install 
else
    __install && echo "Done! The changes will appear once you reboot."
fi

