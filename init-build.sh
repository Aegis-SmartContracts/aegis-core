#!/bin/sh

QT_ROOT=$HOME/opt/qt5.5.0
BOOST_ROOT=$HOME/opt/boost_1_57_0
GENESIS_JSON=$1

if [ $1 = '--clean' ]; then \
  git submodule update --init --recursive \
    && make clean \
    && rm -f CMakeCache.txt \
    && find . -name CMakeFiles | xargs rm -Rf;\
else \
  if [ $2 = '--prod' ]; then \
    cmake -DCMAKE_PREFIX_PATH="$QT_ROOT" \
      -DCMAKE_MODULE_PATH="$QT_ROOT/lib/cmake/Qt5Core" \
      -DQT_QMAKE_EXECUTABLE="$QT_ROOT/bin/qmake" \
      -DBUILD_QT_GUI=TRUE \
      -DGRAPHENE_EGENESIS_JSON="$GENESIS_JSON" \
      -DBOOST_ROOT="$BOOST_ROOT" \
      -DCMAKE_BUILD_TYPE=Debug . ; \
  else \
    cmake  \
      -DGRAPHENE_EGENESIS_JSON="$GENESIS_JSON" \
      -DBOOST_ROOT="$BOOST_ROOT" \
      -DCMAKE_BUILD_TYPE=Debug . ; \
  fi; \
   make -j4 ; \
fi

# example clean
# $ ./init-build.sh --clean
# ---------------------------------------------
# exapmle build
# $ ./init-build.sh ./test-aegis.json
# ----------------------------------------------
# example prod build (qt_guid))
# $ ./init-build.sh ./test-aegis.json --prod
