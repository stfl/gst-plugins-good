PATH_PLUGINS_BASE=/home/slendl/Projects/gst/gst-plugins-base/build
PATH_PLUGINS_GOOD=/home/slendl/Projects/gst/gst-plugins-good/build

(cd $PATH_PLUGINS_BASE; ninja && sudo ninja install >/dev/null)
if [[ $? != 0 ]]; then
   echo build plugins-base failed
   exit 1
fi

(cd $PATH_PLUGINS_GOOD; ninja && sudo ninja install >/dev/null)
if [[ $? != 0 ]]; then
   echo build plugins-good failed
   exit 1
fi

scp $PATH_PLUGINS_BASE/gst-libs/gst/rtp/GstRtp-1.0.gir root@clone:/usr/share/gir-1.0/ &
scp $PATH_PLUGINS_BASE/gst-libs/gst/rtp/GstRtp-1.0.typelib root@clone:/usr/lib/girrepository-1.0 &
scp $PATH_PLUGINS_GOOD/gst/rtp/libgstrtp.so $PATH_PLUGINS_BASE/gst-libs/gst/rtp/libgstrtp-1.0.so* root@clone:/usr/lib/gstreamer-1.0

wait
