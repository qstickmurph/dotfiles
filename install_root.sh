if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Modprobe
# cp etc/modprobe.d/snd.conf /etc/modprobe.d/snd.conf
