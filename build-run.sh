#!/usr/bin/env bash

# Import reusable bits

rm -r -f obj
mkdir obj
export LINKER_OPS=$LINKER_OPS"-aI/usr/include/gtkada  -aI/usr/include/gtk-3.0 -aO/usr/lib64/gtkada -largs -L/usr/lib64/ -lgtkada -Wl,--as-needed -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lharfbuzz -lfontconfig -lgdk_pixbuf-2.0 -lcairo -lfreetype -lglib-2.0 -lpango-1.0 -lgobject-2.0"

echo Building with LINKER_OPS=gnatmake $LINKER_OPS...
gnatmake ./src/main.adb $LINKER_OPS "$@"
mv *.o ./obj
mv *.ali ./obj
./main
